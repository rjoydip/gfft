import { createRequire } from 'node:module'

const require = createRequire(import.meta.url)
const pkg = require('../../package.json')

export default {
  name: pkg.cliname,
  version: pkg.version,
}
