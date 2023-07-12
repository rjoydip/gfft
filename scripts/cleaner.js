import { $ } from 'zx'
import ora from 'ora'
import sade from 'sade'
import { serializeError } from 'serialize-error'

process.on('unhandledRejection', (reason, _) => {
  console.error(reason)
  process.exit(1)
})

async function cleanFile(fileName = '') {
  const eslintcacheLoader = ora(`Removing ${fileName} file`).start();
  eslintcacheLoader.color = 'yellow'
  $`rm -f ${fileName}`
  eslintcacheLoader.color = 'green'
  eslintcacheLoader.stop()
}

async function cleanDir(dirName = '') {
  const eslintcacheLoader = ora(`Removing ${dirName} directory`).start();
  eslintcacheLoader.color = 'yellow'
  $`rm -rf ${dirName}`
  eslintcacheLoader.color = 'green'
  eslintcacheLoader.stop()
}

async function cleanNested(src = '', dest = '') {
  const eslintcacheLoader = ora(`Removing ${src}/**/${dest}`).start();
  eslintcacheLoader.color = 'yellow'
  $`rm -rf ${src}/**/${dest}`
  eslintcacheLoader.color = 'green'
  eslintcacheLoader.stop()
}

void async function () {
  const prog = sade('Cleaner')

  prog
    .command('clean')
    .describe('Clean unnecessary directories')
    .option('-cnm, --clean-nm', 'Clean node_modules directories')
    .example('clean')
    .action(async (opts) => {
      try {
        const spinner = ora(`Cleanup started`).start();
        spinner.color = 'yellow'
        if (opts.cnm) {
          cleanDir('node_modules')
          cleanNested('packages', 'node_modules')
          $`rm -rf packages/node_modules`
        } else {
          cleanDir('coverage')
          cleanFile('.eslintcache')
          cleanDir('.pnpm-store')
          cleanNested('packages', 'dist')
          cleanNested('fixtures', 'output')
        }
        spinner.color = 'green'
        spinner.stop()
      } catch (err) {
        const error = new Error(String(err))
        const serialized = serializeError(error)
        console.error(serialized.message)
      }
    })

  prog.parse(process.argv)
}()
