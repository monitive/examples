// Node 20+ required (uses built-in fetch, no dependencies)
const BASE = 'https://api.monitive.com/api/v1';
const KEY = process.env.MONITIVE_API_KEY;

if (!KEY) {
  console.error('MONITIVE_API_KEY is not set');
  process.exit(1);
}

async function request(method, path, body) {
  const res = await fetch(`${BASE}${path}`, {
    method,
    headers: {
      Authorization: `Bearer ${KEY}`,
      ...(body ? { 'Content-Type': 'application/json' } : {}),
    },
    body: body ? JSON.stringify(body) : undefined,
  });
  if (!res.ok) {
    const text = await res.text().catch(() => '');
    const retryAfter = res.headers.get('Retry-After');
    const hint = retryAfter ? ` (Retry-After: ${retryAfter}s)` : '';
    throw new Error(`HTTP ${res.status} ${res.statusText}${hint}: ${text}`);
  }
  const text = await res.text();
  return text ? JSON.parse(text) : null;
}

const timestamp = Date.now();
const monitorUrl = `https://example.com/?um_examples_run=${timestamp}`;
const monitorName = `examples-repo-smoke-test-${timestamp}`;
let monitorId = null;

try {
  // 1. Create
  console.log('Creating monitor...');
  const created = await request('POST', '/monitors', {
    name: monitorName,
    url: monitorUrl,
    type: 'http',
  });
  monitorId = created.monitor.id;
  console.log(`  Created: id=${monitorId}`);

  // 2. List
  console.log('Listing monitors...');
  const list = await request('GET', '/monitors');
  console.log(`  Found ${list.length} monitor(s)`);

  // 3. Get state
  console.log('Fetching monitor state...');
  const stateData = await request('GET', `/monitors/${monitorId}`);
  const status = stateData?.state?.status ?? stateData?.state ?? 'unknown';
  console.log(`  State: ${status}`);

  // 4. Run test
  console.log('Running test...');
  const testResult = await request('POST', `/monitors/${monitorId}/test`);
  const testState = testResult?.state?.status ?? testResult?.state ?? 'unknown';
  console.log(`  Test result: ${testState}`);
} finally {
  if (monitorId) {
    console.log('Deleting monitor...');
    try {
      await request('DELETE', `/monitors/${monitorId}`);
      monitorId = null;
      console.log('  Deleted.');
    } catch (err) {
      console.warn(`  Warning: cleanup failed — delete monitor ${monitorId} manually: ${err.message}`);
    }
  }
}

console.log('Done — account left clean.');
