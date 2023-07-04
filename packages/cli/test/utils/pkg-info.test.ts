import { describe, expect, test } from 'vitest'
import pkgInfo from '../../src/utils/pkg-info'

describe('pkg info', async () => {
  test('name', () => {
    expect(pkgInfo.name).toStrictEqual('GRFT')
  })
  test('version', () => {
    expect(pkgInfo.version).toStrictEqual('0.1.0')
  })
})
