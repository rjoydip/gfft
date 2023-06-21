import { defineConfig, mergeConfig } from 'vitest/config'
import configShared from '../../vite.shared'

export default mergeConfig(
  configShared,
  defineConfig({
    test: {},
  }),
)
