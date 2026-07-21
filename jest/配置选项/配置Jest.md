参考文档: [配置 Jest](https://jest.nodejs.cn/docs/configuration)

# 配置 Jest

Jest 的理念是默认情况下可以很好地工作，但有时你只需要更多的配置能力。

建议在专用的 JavaScript、TypeScript 或 JSON 文件中定义配置。如果文件名为 `jest.config.js|ts|mjs|cjs|cts|json`，系统会自动发现该文件。你可以使用 --config 标志来传递文件的显式路径。

注意

请记住，生成的配置对象必须始终是 JSON 可序列化的。

配置文件应该简单地导出一个对象：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  verbose: true,
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  verbose: true,
};

export default config;

```

或者返回一个对象的函数：

* JavaScript
* TypeScript

```
/** @returns {Promise<import('jest').Config>} */
module.exports = async () => {
  return {
    verbose: true,
  };
};

```

```
import type {Config} from 'jest';

export default async (): Promise<Config> => {
  return {
    verbose: true,
  };
};

```

提示

默认情况下，Jest 需要 ts-node 才能读取 TypeScript 配置文件。你可以通过在文件顶部添加 `@jest-config-loader` 文档块来覆盖此行为。目前，ts-node 和 esbuild-register 均受支持。确保已安装 `ts-node` 或你指定的加载器。

jest.config.ts

```
/** @jest-config-loader ts-node */
// or
/** @jest-config-loader esbuild-register */

import type {Config} from 'jest';

const config: Config = {
  verbose: true,
};

export default config;

```

你还可以将选项传递给加载器，例如启用 `transpileOnly`。

jest.config.ts

```
/** @jest-config-loader ts-node */
/** @jest-config-loader-options {"transpileOnly": true} */

import type {Config} from 'jest';

const config: Config = {
  verbose: true,
};

export default config;

```

配置也可以作为普通对象存储在 JSON 文件中：

jest.config.json

```
{
  "bail": 1,
  "verbose": true
}

```

或者，可以通过项目的 `package.json` 中的 `"jest"` 键定义 Jest 的配置：

package.json

```
{
  "name": "my-project",
  "jest": {
    "verbose": true
  }
}

```

此外，Jest 的配置 json 文件可以通过项目 `package.json` 字段中的 `"jest"` 键引用：

package.json

```
{
  "name": "my-project",
  "jest": "./path/to/config.json"
}

```

## 选项

信息

如果需要，你可以从 `jest-config` 检索 Jest 的默认值以扩展它们：

* JavaScript
* TypeScript

```
const {defaults} = require('jest-config');

/** @type {import('jest').Config} */
const config = {
  moduleDirectories: [...defaults.moduleDirectories, 'bower_components'],
};

module.exports = config;

```

```
import type {Config} from 'jest';
import {defaults} from 'jest-config';

const config: Config = {
  moduleDirectories: [...defaults.moduleDirectories, 'bower_components'],
};

export default config;

```

* automock [boolean]
* bail [number | boolean]
* cacheDirectory [string]
* clearMocks [boolean]
* collectCoverage [boolean]
* collectCoverageFrom [array]
* coverageDirectory [string]
* coveragePathIgnorePatterns [array<string>]
* coverageProvider [string]
* coverageReporters [array<string | [string, options]>]
* coverageThreshold [object]
* dependencyExtractor [string]
* displayName [string, object]
* errorOnDeprecated [boolean]
* extensionsToTreatAsEsm [array<string>]
* fakeTimers [object]
* forceCoverageMatch [array<string>]
* globals [object]
* globalSetup [string]
* globalTeardown [string]
* haste [object]
* injectGlobals [boolean]
* maxConcurrency [number]
* maxWorkers [number | string]
* moduleDirectories [array<string>]
* moduleFileExtensions [array<string>]
* moduleNameMapper [object<string, string | array<string>>]
* modulePathIgnorePatterns [array<string>]
* modulePaths [array<string>]
* notify [boolean]
* notifyMode [string]
* openHandlesTimeout [number]
* preset [string]
* prettierPath [string]
* projects [array<string | ProjectConfig>]
* randomize [boolean]
* reporters [array<moduleName | [moduleName, options]>]
* resetMocks [boolean]
* resetModules [boolean]
* resolver [string]
* restoreMocks [boolean]
* rootDir [string]
* roots [array<string>]
* runner [string]
* sandboxInjectedGlobals [array<string>]
* setupFiles [array]
* setupFilesAfterEnv [array]
* showSeed [boolean]
* slowTestThreshold [number]
* snapshotFormat [object]
* snapshotResolver [string]
* snapshotSerializers [array<string>]
* testEnvironment [string]
* testEnvironmentOptions [Object]
* testFailureExitCode [number]
* testMatch [string | array<string>]
* testPathIgnorePatterns [array<string>]
* testRegex [string | array<string>]
* testResultsProcessor [string]
* testRunner [string]
* testSequencer [string]
* testTimeout [number]
* transform [object<string, pathToTransformer | [pathToTransformer, object]>]
* transformIgnorePatterns [array<string>]
* unmockedModulePathPatterns [array<string>]
* verbose [boolean]
* waitForUnhandledRejections [boolean]
* watchPathIgnorePatterns [array<string>]
* watchPlugins [array<string | [string, Object]>]
* watchman [boolean]
* workerIdleMemoryLimit [number|string]
* // [string]
* workerThreads

---

## 参考

### `automock` [boolean]

默认：`false`

此选项告诉 Jest 测试中的所有导入模块都应该自动模拟。测试中使用的所有模块都将有一个替换实现，保留 API 表面。

示例：

utils.js

```
export default {
  authorize: () => 'token',
  isAuthorized: secret => secret === 'wizard',
};

```

__tests__/automock.test.js

```
import utils from '../utils';

test('if utils mocked automatically', () => {
  // Public methods of `utils` are now mock functions
  expect(utils.authorize.mock).toBeTruthy();
  expect(utils.isAuthorized.mock).toBeTruthy();

  // You can provide them with your own implementation
  // or pass the expected return value
  utils.authorize.mockReturnValue('mocked_token');
  utils.isAuthorized.mockReturnValue(true);

  expect(utils.authorize()).toBe('mocked_token');
  expect(utils.isAuthorized('not_wizard')).toBeTruthy();
});

```

注意

当你进行手动模拟时，节点模块会自动模拟（例如：`__mocks__/lodash.js`）。更多信息 此处。

Node.js 核心模块（如 `fs`）默认情况下不会被模拟。它们可以被明确地模拟，比如 `jest.mock('fs')`。

### `bail` [number | boolean]

默认：`0`

默认情况下，Jest 运行所有测试并在完成后将所有错误生成到控制台中。此处可以使用 bail 配置选项让 Jest 在 `n` 次失败后停止运行测试。将保释设置为 `true` 与将保释设置为 `1` 相同。

### `cacheDirectory` [string]

默认：`"/tmp/<path>"`

Jest 应存储其缓存的依赖信息的目录。

Jest 尝试一次（预先）扫描你的依赖树并将其缓存，以缓解运行测试时需要发生的一些文件系统混乱。此配置选项允许你自定义 Jest 在磁盘上存储缓存数据的位置。

### `clearMocks` [boolean]

默认：`false`

每次测试前自动清除模拟调用、实例、上下文和结果。相当于每次测试前调用 jest.clearAllMocks()。这不会删除可能已提供的任何模拟实现。

### `collectCoverage` [boolean]

默认：`false`

指示执行测试时是否应收集覆盖率信息。由于这会使用覆盖率收集语句改进所有执行的文件，因此可能会显着减慢你的测试速度。

Jest 附带两个承保提供商：`babel`（默认）和 `v8`。有关详细信息，请参阅 coverageProvider 选项。

信息

`babel` 和 `v8` 覆盖率提供程序分别使用 `/* istanbul ignore next */` 和 `/* c8 ignore next */` 注释从覆盖率报告中排除行。有关更多信息，你可以查看 istanbuljs 文档 和 c8 文档。

### `collectCoverageFrom` [array]

默认：`undefined`

通配符模式 数组，指示应收集其覆盖范围信息的一组文件。如果文件与指定的 glob 模式匹配，即使该文件不存在测试并且测试套件中从不需要它，也会为其收集覆盖信息。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  collectCoverageFrom: [
    '**/*.{js,jsx}',
    '!**/node_modules/**',
    '!**/vendor/**',
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  collectCoverageFrom: [
    '**/*.{js,jsx}',
    '!**/node_modules/**',
    '!**/vendor/**',
  ],
};

export default config;

```

这将收集项目 `rootDir` 内所有文件的覆盖范围信息，但与 `**/node_modules/**` 或 `**/vendor/**` 匹配的文件除外。

提示

每个 glob 模式都按照它们在配置中指定的顺序应用。例如，`["!**/__tests__/**", "**/*.js"]` 不会排除 `__tests__`，因为否定被第二个模式覆盖。为了使本例中的否定 glob 起作用，它必须位于 `**/*.js` 之后。

注意

此选项要求将 `collectCoverage` 设置为 `true` 或使用 `--coverage` 调用 Jest。

Help:

如果你看到覆盖输出，例如...

```
=============================== Coverage summary ===============================
Statements   : Unknown% ( 0/0 )
Branches     : Unknown% ( 0/0 )
Functions    : Unknown% ( 0/0 )
Lines        : Unknown% ( 0/0 )
================================================================================
Jest: Coverage data for global was not found.

```

你的 glob 模式很可能与任何文件都不匹配。请参阅 micromatch 文档以确保你的 glob 兼容。

### `coverageDirectory` [string]

默认：`undefined`

Jest 应输出其覆盖范围文件的目录。

### `coveragePathIgnorePatterns` [array<string>]

默认：`["/node_modules/"]`

在执行测试之前与所有文件路径匹配的正则表达式模式字符串数组。如果文件路径与任何模式匹配，则将跳过覆盖信息。

这些模式字符串与完整路径匹配。使用 `<rootDir>` 字符串标记包含项目根目录的路径，以防止项目意外忽略可能具有不同根目录的不同环境中的所有文件。示例：`["<rootDir>/build/", "<rootDir>/node_modules/"]`。

### `coverageProvider` [string]

指示应使用哪个提供商来检测代码的覆盖范围。允许的值为 `babel`（默认）或 `v8`。

### `coverageReporters` [array<string | [string, options]>]

默认：`["clover", "json", "lcov", "text"]`

Jest 在撰写报道报告时使用的报告器名称列表。任何 伊斯坦布尔报告器报 都可以使用。

提示

设置此选项会覆盖默认值。添加 `"text"` 或 `"text-summary"` 以在控制台输出中查看覆盖率摘要。

可以使用元组形式传递附加选项。例如，你可以隐藏所有完全覆盖文件的覆盖率报告行：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  coverageReporters: ['clover', 'json', 'lcov', ['text', {skipFull: true}]],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  coverageReporters: ['clover', 'json', 'lcov', ['text', {skipFull: true}]],
};

export default config;

```

有关选项对象形状的更多信息，请参阅 类型定义 中的 `CoverageReporterWithOptions` 类型。

### `coverageThreshold` [object]

默认：`undefined`

这将用于配置覆盖结果的最小阈值强制执行。阈值可以指定为 `global`、glob 以及目录或文件路径。如果未达到阈值，Jest 就会失败。指定为正数的阈值被视为所需的最小百分比。指定为负数的阈值表示允许的未覆盖实体的最大数量。

例如，使用以下配置，如果分支、行和函数覆盖率低于 80%，或者未覆盖的语句超过 10 个，则 jest 将会失败：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: -10,
    },
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: -10,
    },
  },
};

export default config;

```

如果与 `global` 一起指定了 glob 或路径，则将从总体覆盖范围中减去匹配路径的覆盖数据，并且将独立应用阈值。glob 的阈值应用于与该 glob 匹配的所有文件。如果未找到路径指定的文件，则返回错误。

例如，使用以下配置：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  coverageThreshold: {
    global: {
      branches: 50,
      functions: 50,
      lines: 50,
      statements: 50,
    },
    './src/components/': {
      branches: 40,
      statements: 40,
    },
    './src/reducers/**/*.js': {
      statements: 90,
    },
    './src/api/very-important-module.js': {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  coverageThreshold: {
    global: {
      branches: 50,
      functions: 50,
      lines: 50,
      statements: 50,
    },
    './src/components/': {
      branches: 40,
      statements: 40,
    },
    './src/reducers/**/*.js': {
      statements: 90,
    },
    './src/api/very-important-module.js': {
      branches: 100,
      functions: 100,
      lines: 100,
      statements: 100,
    },
  },
};

export default config;

```

如果出现以下情况，Jest 就会失败：

* `./src/components` 目录的分支或语句覆盖率低于 40%。  
* 与 `./src/reducers/**/*.js` glob 匹配的文件之一的语句覆盖率低于 90%。  
* `./src/api/very-important-module.js` 文件的覆盖率低于 100%。  
* 每个剩余文件的总覆盖率均低于 50% (`global`)。  

### `dependencyExtractor` [string]

默认：`undefined`

此选项允许使用自定义依赖提取器。它必须是一个导出具有 `extract` 函数的对象的节点模块。例如。：

```
const crypto = require('crypto');
const fs = require('fs');

module.exports = {
  extract(code, filePath, defaultExtract) {
    const deps = defaultExtract(code, filePath);
    // Scan the file and add dependencies in `deps` (which is a `Set`)
    return deps;
  },
  getCacheKey() {
    return crypto
      .createHash('md5')
      .update(fs.readFileSync(__filename))
      .digest('hex');
  },
};

```

`extract` 函数应该返回一个可迭代对象（`Array`、`Set` 等），并在代码中找到依赖。

该模块还可以包含 `getCacheKey` 函数来生成缓存密钥，以确定逻辑是否已更改以及依赖于它的任何缓存工件是否应被丢弃。

### `displayName` [string, object]

默认：`undefined`

允许在测试运行时与测试一起打印标签。这在可能有许多 Jest 配置文件的多项目存储库中变得更加有用。这可以直观地告诉你测试属于哪个项目。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  displayName: 'CLIENT',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  displayName: 'CLIENT',
};

export default config;

```

或者，可以传递具有属性 `name` 和 `color` 的对象。这允许自定义配置 displayName 的背景颜色。当其值为字符串时，`displayName` 默认为白色。Jest 使用 chalk 来提供颜色。因此，Jest 也支持 `chalk` 支持的所有有效颜色选项。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  displayName: {
    name: 'CLIENT',
    color: 'blue',
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  displayName: {
    name: 'CLIENT',
    color: 'blue',
  },
};

export default config;

```

### `errorOnDeprecated` [boolean]

默认：`false`

让调用已弃用的 API 抛出有用的错误消息。对于简化升级过程很有用。

### `extensionsToTreatAsEsm` [array<string>]

默认：`[]`

Jest 将运行 `.mjs` 和 `.js` 文件，并将最近的 `package.json` 的 `type` 字段设置为 `module` 作为 ECMAScript 模块。如果你有任何其他应与原生 ESM 一起运行的文件，则需要在此处指定其文件扩展名。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  extensionsToTreatAsEsm: ['.ts'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  extensionsToTreatAsEsm: ['.ts'],
};

export default config;

```

提醒

Jest 的 ESM 支持仍处于实验阶段，请参阅 其文档了解更多详细信息。

### `fakeTimers` [object]

默认：`{}`

当一段代码设置了我们不想在测试中等待的长时间超时时，假计时器可能会很有用。有关更多详细信息，请参阅 假定时器指南 和 API 文档。

此选项为所有测试提供假定时器的默认配置。在测试文件中调用 `jest.useFakeTimers()` 将使用这些选项，或者在传递配置对象时覆盖它们。例如，你可以告诉 Jest 保留 `process.nextTick()` 的原始实现并调整将运行的递归计时器的限制：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  fakeTimers: {
    doNotFake: ['nextTick'],
    timerLimit: 1000,
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  fakeTimers: {
    doNotFake: ['nextTick'],
    timerLimit: 1000,
  },
};

export default config;

```

fakeTime.test.js

```
// install fake timers for this file using the options from Jest configuration
jest.useFakeTimers();

test('increase the limit of recursive timers for this and following tests', () => {
  jest.useFakeTimers({timerLimit: 5000});
  // ...
});

```

提示

你可以为 Jest 配置中的所有测试全局启用伪计时器，而不是在每个测试文件中包含 `jest.useFakeTimers()`：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  fakeTimers: {
    enableGlobally: true,
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  fakeTimers: {
    enableGlobally: true,
  },
};

export default config;

```

配置选项：

```
type FakeableAPI =
  | 'Date'
  | 'hrtime'
  | 'nextTick'
  | 'performance'
  | 'queueMicrotask'
  | 'requestAnimationFrame'
  | 'cancelAnimationFrame'
  | 'requestIdleCallback'
  | 'cancelIdleCallback'
  | 'setImmediate'
  | 'clearImmediate'
  | 'setInterval'
  | 'clearInterval'
  | 'setTimeout'
  | 'clearTimeout';

type ModernFakeTimersConfig = {
  /**

   * If set to `true` all timers will be advanced automatically by 20 milliseconds

   * every 20 milliseconds. A custom time delta may be provided by passing a number.

   * The default is `false`.
   */
  advanceTimers?: boolean | number;
  /**

   * List of names of APIs that should not be faked. The default is `[]`, meaning

   * all APIs are faked.
   */
  doNotFake?: Array<FakeableAPI>;
  /** Whether fake timers should be enabled for all test files. The default is `false`. */
  enableGlobally?: boolean;
  /**

   * Use the old fake timers implementation instead of one backed by `@sinonjs/fake-timers`.

   * The default is `false`.
   */
  legacyFakeTimers?: boolean;
  /** Sets current system time to be used by fake timers, in milliseconds. The default is `Date.now()`. */
  now?: number;
  /** Maximum number of recursive timers that will be run. The default is `100_000` timers. */
  timerLimit?: number;
};

```

旧版假定时器

由于某种原因，你可能必须使用假计时器的旧版实现。以下是全局启用它的方法（不支持其他选项）：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  fakeTimers: {
    enableGlobally: true,
    legacyFakeTimers: true,
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  fakeTimers: {
    enableGlobally: true,
    legacyFakeTimers: true,
  },
};

export default config;

```

### `forceCoverageMatch` [array<string>]

默认：`['']`

收集代码覆盖率时通常会忽略测试文件。使用此选项，你可以覆盖此行为，并将其他被忽略的文件包含在代码覆盖率中。

例如，如果你在以 `.t.js` 扩展名命名的源文件中进行测试，如下所示：

sum.t.js

```
export function sum(a, b) {
  return a + b;
}

if (process.env.NODE_ENV === 'test') {
  test('sum', () => {
    expect(sum(1, 2)).toBe(3);
  });
}

```

你可以通过设置 `forceCoverageMatch` 从这些文件中收集覆盖率。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  forceCoverageMatch: ['**/*.t.js'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  forceCoverageMatch: ['**/*.t.js'],
};

export default config;

```

### `globals` [object]

默认：`{}`

一组需要在所有测试环境中可用的全局变量。

例如，以下命令将在所有测试环境中创建设置为 `true` 的全局 `__DEV__` 变量：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  globals: {
    __DEV__: true,
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  globals: {
    __DEV__: true,
  },
};

export default config;

```

注意

如果你在此处指定全局引用值（例如对象或数组），并且某些代码在运行测试期间更改了该值，则该更改将不会在其他测试文件的测试运行中持续存在。此外，`globals` 对象必须是 json 可序列化的，因此它不能用于指定全局函数。为此，你应该使用 `setupFiles`。

### `globalSetup` [string]

默认：`undefined`

此选项允许使用自定义全局设置模块，该模块必须导出函数（可以是同步或异步）。该函数将在所有测试套件之前触发一次，并将接收两个参数：Jest 的 globalConfig 和 projectConfig。

信息

仅当你从该项目运行至少一个测试时，才会触发项目中配置的全局设置模块（使用多项目运行器）。

通过 `globalSetup` 定义的任何全局变量只能在 `globalTeardown` 中读取。你无法检索测试套件中此处定义的全局变量。

虽然代码转换应用于链接的安装文件，但 Jest 不会转换 `node_modules` 中的任何代码。这是因为需要加载实际的转换器（例如 `babel` 或 `typescript`）来执行转换。

setup.js

```
module.exports = async function (globalConfig, projectConfig) {
  console.log(globalConfig.testPathPatterns);
  console.log(projectConfig.cache);

  // Set reference to mongod in order to close the server during teardown.
  globalThis.__MONGOD__ = mongod;
};

```

teardown.js

```
module.exports = async function (globalConfig, projectConfig) {
  console.log(globalConfig.testPathPatterns);
  console.log(projectConfig.cache);

  await globalThis.__MONGOD__.stop();
};

```

### `globalTeardown` [string]

默认：`undefined`

此选项允许使用必须导出函数的自定义全局拆卸模块（可以是同步或异步）。该函数将在所有测试套件之后被触发一次，并且它将接收两个参数：Jest 的 globalConfig 和 projectConfig。

信息

仅当你从该项目运行至少一个测试时，才会触发项目中配置的全局拆卸模块（使用多项目运行器）。

关于 `node_modules` 转换的与 `globalSetup` 转换相同的警告也适用于 `globalTeardown`。

### `haste` [object]

默认：`undefined`

这将用于配置 `jest-haste-map`（Jest 的内部文件爬虫/缓存系统）的行为。支持以下选项：

```
type HasteConfig = {
  /** Whether to hash files using SHA-1. */
  computeSha1?: boolean;
  /** The platform to use as the default, e.g. 'ios'. */
  defaultPlatform?: string | null;
  /** Force use of Node's `fs` APIs rather than shelling out to `find` */
  forceNodeFilesystemAPI?: boolean;
  /**

   * Whether to follow symlinks when crawling for files.

   *   This options cannot be used in projects which use watchman.

   *   Projects with `watchman` set to true will error if this option is set to true.
   */
  enableSymlinks?: boolean;
  /** Path to a custom implementation of Haste. */
  hasteImplModulePath?: string;
  /** All platforms to target, e.g ['ios', 'android']. */
  platforms?: Array<string>;
  /** Whether to throw an error on module collision. */
  throwOnModuleCollision?: boolean;
  /** Custom HasteMap module */
  hasteMapModulePath?: string;
  /** Whether to retain all files, allowing e.g. search for tests in `node_modules`. */
  retainAllFiles?: boolean;
};

```

### `injectGlobals` [boolean]

默认：`true`

将 Jest 的全局变量（`expect`、`test`、`describe`、`beforeEach` 等）插入全局环境中。如果将其设置为 `false`，则应从 `@jest/globals` 导入，例如

```
import {expect, jest, test} from '@jest/globals';

jest.useFakeTimers();

test('some test', () => {
  expect(Date.now()).toBe(0);
});

```

注意

仅使用默认的 `jest-circus` 测试运行程序才支持此选项。

### `maxConcurrency` [number]

默认：`5`

使用 `test.concurrent` 时限制允许同时运行的测试数量的数字。一旦插槽被释放，任何超过此限制的测试都将排队并执行。

### `maxWorkers` [number | string]

指定工作池为运行测试而生成的最大工作进程数量。在单运行模式下，这默认为计算机上可用的核心数减去主线程的一数。在监视模式下，这默认为机器上可用内核的一半，以确保 Jest 不引人注目并且不会让你的机器停止运行。在 CI 等资源有限的环境中调整此设置可能很有用，但默认值应该足以满足大多数用例。

对于具有可用可变 CPU 的环境，你可以使用基于百分比的配置：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  maxWorkers: '50%',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  maxWorkers: '50%',
};

export default config;

```

### `moduleDirectories` [array<string>]

默认：`["node_modules"]`

要从所需模块的位置向上递归搜索的目录名称数组。如果你仍希望搜索 `node_modules` 中的包，设置此选项将覆盖默认值，请将其与任何其他选项一起包括在内：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  moduleDirectories: ['node_modules', 'bower_components'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  moduleDirectories: ['node_modules', 'bower_components'],
};

export default config;

```

提醒

不鼓励将 `'.'` 用作 `moduleDirectories` 之一，因为这会阻止范围包（例如 `@emotion/react`）访问具有相同子目录名称（`react`）的包。详细信息请参见 这个问题。在大多数情况下，最好使用 moduleNameMapper 配置。

### `moduleFileExtensions` [array<string>]

默认：`["js", "mjs", "cjs", "jsx", "ts", "mts", "cts", "tsx", "json", "node"]`

你的模块使用的文件扩展名数组。如果你需要不指定文件扩展名的模块，这些是 Jest 将从左到右的顺序查找的扩展名。

我们建议将项目中最常用的扩展放在左侧，因此如果你使用 TypeScript，你可能需要考虑将 "ts" 和/或 "tsx" 移动到数组的开头。

### `moduleNameMapper` [object<string, string | array<string>>]

默认：`null`

从正则表达式到模块名称或模块名称数组的映射，允许使用单个模块存根资源，例如图片或样式。

默认情况下，无论是否启用自动模拟，映射到别名的模块都不会被模拟。

如果要使用文件路径，请使用 `<rootDir>` 字符串标记来引用 rootDir 值。

此外，你可以使用编号反向引用替换捕获的正则表达式组。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  moduleNameMapper: {
    '^image![a-zA-Z0-9$_-]+$': 'GlobalImageStub',
    '^[./a-zA-Z0-9$_-]+\\.png$': '<rootDir>/RelativeImageStub.js',
    'module_name_(.*)': '<rootDir>/substituted_module_$1.js',
    'assets/(.*)': [
      '<rootDir>/images/$1',
      '<rootDir>/photos/$1',
      '<rootDir>/recipes/$1',
    ],
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  moduleNameMapper: {
    '^image![a-zA-Z0-9$_-]+$': 'GlobalImageStub',
    '^[./a-zA-Z0-9$_-]+\\.png$': '<rootDir>/RelativeImageStub.js',
    'module_name_(.*)': '<rootDir>/substituted_module_$1.js',
    'assets/(.*)': [
      '<rootDir>/images/$1',
      '<rootDir>/photos/$1',
      '<rootDir>/recipes/$1',
    ],
  },
};

export default config;

```

定义映射的顺序很重要。图案被一件一件地检查，直到一件合适为止。最具体的规则应首先列出。对于模块名称数组也是如此。

信息

如果你提供没有边界 `^$` 的模块名称，可能会导致难以发现错误。例如。`relay` 将替换名称中包含 `relay` 作为子字符串的所有模块：`relay`、`react-relay` 和 `graphql-relay` 将全部指向你的存根。

### `modulePathIgnorePatterns` [array<string>]

默认：`[]`

与所有模块路径相匹配的正则表达式模式字符串数组，在这些路径被模块加载器视为 'visible' 之前。如果给定模块的路径与任何模式匹配，则它在测试环境中将不支持 `require()`。

这些模式字符串与完整路径匹配。使用 `<rootDir>` 字符串标记包含项目根目录的路径，以防止项目意外忽略可能具有不同根目录的不同环境中的所有文件。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  modulePathIgnorePatterns: ['<rootDir>/build/'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  modulePathIgnorePatterns: ['<rootDir>/build/'],
};

export default config;

```

### `modulePaths` [array<string>]

默认：`[]`

设置 `NODE_PATH` 环境变量的替代 API，`modulePaths` 是解析模块时要搜索的其他位置的绝对路径数组。使用 `<rootDir>` 字符串标记包含项目根目录的路径。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  modulePaths: ['<rootDir>/app/'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  modulePaths: ['<rootDir>/app/'],
};

export default config;

```

### `notify` [boolean]

默认：`false`

激活测试结果的原生操作系统通知。要显示通知 Jest 需要 node-notifier 软件包，必须另外安装：

* npm
* Yarn
* pnpm

```
npm install --save-dev node-notifier

```

```
yarn add --dev node-notifier

```

```
pnpm add --save-dev node-notifier

```

提示

在 macOS 上，请记住在“系统偏好设置”>“通知和焦点”下允许来自 `terminal-notifier` 的通知。

在 Windows 上，`node-notifier` 在第一次使用时创建一个新的开始菜单条目，并且不显示通知。通知将在后续运行中正确显示。

### `notifyMode` [string]

默认：`failure-change`

指定通知模式。需要 `notify: true`。

#### 模式

* `always`：始终发送通知。  
* `failure`：当测试失败时发送通知。  
* `success`：测试通过时发送通知。  
* `change`：当状态改变时发送通知。  
* `success-change`：当测试通过时发送通知或当测试失败时发送一次通知。  
* `failure-change`：当测试失败时发送通知或当测试通过时发送一次通知。  

### `openHandlesTimeout` [number]

默认：`1000`

打印一条警告，指示如果 Jest 在完成后的毫秒数内未完全退出，则可能存在打开的句柄。使用 `0` 禁用警告。

### `preset` [string]

默认：`undefined`

用作 Jest 配置基础的预设。预设应指向根目录下有 `jest-preset.json`、`jest-preset.js`、`jest-preset.cjs` 或 `jest-preset.mjs` 文件的 npm 模块。

例如，该预设 `foo-bar/jest-preset.js` 将配置如下：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  preset: 'foo-bar',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  preset: 'foo-bar',
};

export default config;

```

预设也可能与文件系统路径相关：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  preset: './node_modules/foo-bar/jest-preset.js',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  preset: './node_modules/foo-bar/jest-preset.js',
};

export default config;

```

信息

如果你还指定了 rootDir，则该文件的解析将相对于该根目录。

### `prettierPath` [string]

默认：`'prettier'`

设置用于更新内联快照的 prettier 节点模块的路径。

### `projects` [array<string | ProjectConfig>]

默认：`undefined`

当 `projects` 配置提供路径数组或 glob 模式时，Jest 将同时在所有指定项目中运行测试。这对于单一存储库或同时处理多个项目时非常有用。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  projects: ['<rootDir>', '<rootDir>/examples/*'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  projects: ['<rootDir>', '<rootDir>/examples/*'],
};

export default config;

```

此示例配置将在根目录以及示例目录中的每个文件夹中运行 Jest。你可以在同一个 Jest 实例中运行无限数量的项目。

项目功能还可用于运行多个配置或多个 runners。为此，你可以传递配置对象数组。例如，要在同一 Jest 调用中运行测试和 ESLint（通过 jest-runner-eslint）：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  projects: [
    {
      displayName: 'test',
    },
    {
      displayName: 'lint',
      runner: 'jest-runner-eslint',
      testMatch: ['<rootDir>/**/*.js'],
    },
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  projects: [
    {
      displayName: 'test',
    },
    {
      displayName: 'lint',
      runner: 'jest-runner-eslint',
      testMatch: ['<rootDir>/**/*.js'],
    },
  ],
};

export default config;

```

提示

使用多项目运行器时，建议为每个项目添加 `displayName`。这将在其测试旁边显示项目的 `displayName`。

注意

启用 `projects` 选项后，Jest 将在测试运行期间将根级配置选项复制到每个单独的子配置，并在子上下文中解析其值。这意味着像 `<rootDir>` 这样的字符串标记将指向子级的根目录，即使它们是在根级配置中定义的。

### `randomize` [boolean]

默认：`false`

相当于 \--randomize 标志，用于随机化文件中测试的顺序。

### `reporters` [array<moduleName | [moduleName, options]>]

默认：`undefined`

使用此配置选项将报告器添加到 Jest。它必须是报告器名称列表，可以使用元组形式将其他选项传递给报告器：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  reporters: [
    'default',
    ['<rootDir>/custom-reporter.js', {banana: 'yes', pineapple: 'no'}],
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  reporters: [
    'default',
    ['<rootDir>/custom-reporter.js', {banana: 'yes', pineapple: 'no'}],
  ],
};

export default config;

```

#### 默认报告者

如果指定了自定义报告器，则默认的 Jest 报告器将被覆盖。如果你想保留它，则必须将 `'default'` 作为报告器名称传递：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  reporters: [
    'default',
    ['jest-junit', {outputDirectory: 'reports', outputName: 'report.xml'}],
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  reporters: [
    'default',
    ['jest-junit', {outputDirectory: 'reports', outputName: 'report.xml'}],
  ],
};

export default config;

```

#### GitHub Actions 报告器

如果包含在列表中，内置的 GitHub Actions Reporter 将使用测试失败消息注释更改的文件，并使用 github 组功能（如果与 `'silent: false'` 一起使用）打印日志，以便于导航。请注意，在这种情况下不应使用 `'default'`，因为 `'github-actions'` 已经会处理该问题，因此请记住还包括 `'summary'`。如果你只想将其用于注释，只需仅保留报告器而不带选项，因为 `'silent'` 的默认值为 `'true'`：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  reporters: [['github-actions', {silent: false}], 'summary'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  reporters: [['github-actions', {silent: false}], 'summary'],
};

export default config;

```

#### 摘要报告器

摘要报告器打印出所有测试的摘要。它是默认报告器的一部分，因此如果 `'default'` 包含在列表中，它将被启用。例如，你可能想将其用作独立报告器而不是默认报告器，或与 沉默的报告器 一起使用：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  reporters: ['jest-silent-reporter', 'summary'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  reporters: ['jest-silent-reporter', 'summary'],
};

export default config;

```

`summary` 报告器接受选项。由于它包含在 `default` 报告器中，你也可以在其中传递选项。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  reporters: [['default', {summaryThreshold: 10}]],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  reporters: [['default', {summaryThreshold: 10}]],
};

export default config;

```

`summaryThreshold` 选项的行为方式如下，如果测试套件的总数超过此阈值，则在执行所有测试后将打印所有失败测试的详细摘要。默认为 `20`。

#### 定制报告器

提示

渴求报告器吗？看看来自 Awesome Jest 的 很棒的报告器 长列表。

自定义报告器模块必须导出一个采用 globalConfig、`reporterOptions` 和 `reporterContext` 作为构造函数参数的类：

custom-reporter.js

```
class CustomReporter {
  constructor(globalConfig, reporterOptions, reporterContext) {
    this._globalConfig = globalConfig;
    this._options = reporterOptions;
    this._context = reporterContext;
  }

  onRunComplete(testContexts, results) {
    console.log('Custom reporter output:');
    console.log('global config:', this._globalConfig);
    console.log('options for this reporter from Jest config:', this._options);
    console.log('reporter context passed from test scheduler:', this._context);
  }

  // Optionally, reporters can force Jest to exit with non zero code by returning
  // an `Error` from `getLastError()` method.
  getLastError() {
    if (this._shouldFail) {
      return new Error('Custom error reported!');
    }
  }
}

module.exports = CustomReporter;

```

注意

有关钩子和参数类型的完整列表，请参阅 包/jest-reporters/src/types.ts 中的 `Reporter` 接口。

### `resetMocks` [boolean]

默认：`false`

每次测试前自动重置模拟状态。相当于每次测试前调用 jest.resetAllMocks()。这将导致任何模拟的假实现被删除，但不会恢复其初始实现。

### `resetModules` [boolean]

默认：`false`

默认情况下，每个测试文件都有自己独立的模块注册表。启用 `resetModules` 更进一步，在运行每个单独的测试之前重置模块注册表。这对于隔离每个测试的模块很有用，这样本地模块状态就不会在测试之间发生冲突。这可以使用 jest.resetModules() 以编程方式完成。

### `resolver` [string]

默认：`undefined`

此选项允许使用自定义解析器。该解析器必须是导出以下任一内容的模块：

1. 一个函数，期望一个字符串作为要解析的路径的第一个参数，一个选项对象作为第二个参数。该函数应该返回应解析的模块的路径，或者如果找不到模块则抛出错误。或者  
2. 包含 `async` 和/或 `sync` 属性的对象。`sync` 属性应该是具有上述形状的函数，`async` 属性也应该是接受相同参数的函数，但返回一个 Promise，该 Promise 使用模块路径解析或因错误而拒绝。  

提供给解析器的选项对象具有以下形状：

```
type ResolverOptions = {
  /** Directory to begin resolving from. */
  basedir: string;
  /** List of export conditions. */
  conditions?: Array<string>;
  /** Instance of default resolver. */
  defaultResolver: (path: string, options: ResolverOptions) => string;
  /** Instance of default async resolver. */
  defaultAsyncResolver: (
    path: string,
    options: ResolverOptions,
  ) => Promise<string>;
  /** List of file extensions to search in order. */
  extensions?: Array<string>;
  /** List of directory names to be looked up for modules recursively. */
  moduleDirectory?: Array<string>;
  /** List of `require.paths` to use if nothing is found in `node_modules`. */
  paths?: Array<string>;
  /** Current root directory. */
  rootDir?: string;
};

```

提示

作为选项传递的 `defaultResolver` 是 Jest 默认解析器，在你编写自定义解析器时可能会很有用。它采用与你的自定义同步参数相同的参数，例如 `(path, options)` 并返回一个字符串或抛出异常。

同样，`defaultAsyncResolver` 是默认的异步解析器，它接受相同的参数并返回一个 Promise，该 Promise 解析后返回字符串，否则返回错误。

例如，如果你想尊重 Browserify 的 "browser" 场，你可以使用以下解析器：

resolver.js

```
const browserResolve = require('browser-resolve');

module.exports = browserResolve.sync;

```

并将其添加到 Jest 配置中：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  resolver: '<rootDir>/resolver.js',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  resolver: '<rootDir>/resolver.js',
};

export default config;

```

Jest 的 `jest-resolve` 依赖于 `unrs-resolver`。我们可以传递其他选项，例如修改 `mainFields` 以进行解析。例如，对于 React Native 项目，你可能需要使用以下配置：

```
module.exports = (path, options) => {
  // Call the defaultResolver, so we leverage its cache, error handling, etc.
  return options.defaultResolver(path, {
    ...options,
    // `unrs-resolver` option: https://github.com/unrs/unrs-resolver#main-field
    mainFields: ['react-native', 'main'],
  });
};

```

你还可以使用 `defaultResolver` 来实现 "pre-processor"，以便我们更改默认解析器解析模块的方式。例如，假设一个 TypeScript 项目需要在运行时引用 `.js` 文件，但在 `.ts` 文件上运行 Jest。

```
module.exports = (path, options) => {
  // Dynamic imports within our codebase that reference .js need to reference
  // .ts during tests.
  if (
    !options.basedir.includes('node_modules') &&
    path.endsWith('.js') &&
    (path.startsWith('../') || path.startsWith('./'))
  ) {
    path = path.replace(/\.js$/, '.ts');
  }

  // Call the defaultResolver, so we leverage its cache, error handling, etc.
  return options.defaultResolver(path, options);
};

```

### `restoreMocks` [boolean]

默认：`false`

在每次测试之前自动恢复模拟状态和实现。相当于每次测试前调用 jest.restoreAllMocks()。这将导致任何模拟的假实现被删除并恢复其初始实现。

### `rootDir` [string]

默认：包含 Jest 配置文件 或 `package.json` 或 pwd 的目录的根目录（如果未找到 `package.json`）

Jest 应扫描其中的测试和模块的根目录。如果你将 Jest 配置放入 `package.json` 中并希望根目录成为存储库的根目录，则此配置参数的值将默认为 `package.json` 的目录。

通常，你需要将其设置为 `'src'` 或 `'lib'`，对应于代码在存储库中的存储位置。

提示

在任何其他基于路径的配置设置中使用 `'<rootDir>'` 作为字符串标记将引用该值。例如，如果你希望 setupFiles 条目指向项目根目录下的 `some-setup.js` 文件，请将其值设置为：`'<rootDir>/some-setup.js'`。

### `roots` [array<string>]

默认：`["<rootDir>"]`

Jest 用于搜索文件的目录路径列表。

有时你只希望 Jest 在单个子目录中搜索（例如存储库中有 `src/` 目录的情况），但阻止它访问存储库的其余部分。

信息

虽然 `rootDir` 主要用作在其他配置选项中重复使用的令牌，但 `roots` 被 Jest 内部用来定位测试文件和源文件。这也适用于从 `node_modules` 搜索模块的手动模拟（`__mocks__` 将需要位于 `roots` 之一）。

默认情况下，`roots` 有一个条目 `<rootDir>`，但在某些情况下你可能希望在一个项目中拥有多个根，例如 `roots: ["<rootDir>/src/", "<rootDir>/tests/"]`。

### `runner` [string]

默认：`"jest-runner"`

此选项允许你使用自定义运行程序而不是 Jest 的默认测试运行程序。运行器的例子包括：

* jest-runner-eslint
* jest-runner-mocha
* jest-runner-tsc
* jest-runner-prettier

信息

`runner` 属性值可以省略包名的 `jest-runner-` 前缀。

要编写测试运行程序，请导出一个类，该类在构造函数中接受 globalConfig，并具有带有签名的 `runTests` 方法：

```
async function runTests(
  tests: Array<Test>,
  watcher: TestWatcher,
  onStart: OnTestStart,
  onResult: OnTestSuccess,
  onFailure: OnTestFailure,
  options: TestRunnerOptions,
): Promise<void>;

```

如果你需要限制测试运行程序仅以串行方式运行而不是并行执行，你的类应该将属性 `isSerial` 设置为 `true`。

### `sandboxInjectedGlobals` [array<string>]

提示

由 Jest 28 中的 `extraGlobals` 重命名。

默认：`undefined`

测试文件在 vm 内运行，这会减慢对全局上下文属性（例如 `Math`）的调用。使用此选项，你可以指定要在虚拟机内定义的额外属性，以加快查找速度。

例如，如果你的测试经常调用 `Math`，则可以通过设置 `sandboxInjectedGlobals` 来通过它。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  sandboxInjectedGlobals: ['Math'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  sandboxInjectedGlobals: ['Math'],
};

export default config;

```

注意

如果你使用 原生 ESM，则此选项无效。

### `setupFiles` [array]

默认：`[]`

运行某些代码以配置或设置测试环境的模块的路径列表。每个 setupFile 将在每个测试文件中运行一次。由于每个测试都在自己的环境中运行，因此这些脚本将在执行 setupFilesAfterEnv 之前和测试代码本身之前在测试环境中执行。

提示

如果你的安装脚本是 CJS 模块，它可能会导出异步函数。Jest 将调用该函数并等待其结果。这对于异步获取一些数据可能很有用。如果文件是 ESM 模块，只需使用顶层 await 即可获得相同的结果。

### `setupFilesAfterEnv` [array]

默认：`[]`

模块的路径列表，这些模块在执行套件中的每个测试文件之前运行一些代码来配置或设置测试框架。由于 setupFiles 在测试框架安装到环境中之前执行，因此此脚本文件为你提供了在测试框架安装到环境中之后但在测试代码本身之前立即运行某些代码的机会。

换句话说，`setupFilesAfterEnv` 模块适用于每个测试文件中重复的代码。安装测试框架后，可以在模块中访问 Jest globals、jest 对象 和 expect。例如，你可以从 jest-extended 库添加额外的匹配器或调用 设置和拆卸 钩子：

setup-jest.js

```
const matchers = require('jest-extended');
expect.extend(matchers);

afterEach(() => {
  jest.useRealTimers();
});

```

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  setupFilesAfterEnv: ['<rootDir>/setup-jest.js'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  setupFilesAfterEnv: ['<rootDir>/setup-jest.js'],
};

export default config;

```

提示

如果你的安装脚本是 CJS 模块，它可能会导出异步函数。Jest 将调用该函数并等待其结果。这对于异步获取一些数据可能很有用。如果文件是 ESM 模块，只需使用顶层 await 即可获得相同的结果。

### `showSeed` [boolean]

默认：`false`

相当于 \--showSeed 标志，用于在测试报告摘要中打印种子。

### `slowTestThreshold` [number]

默认：`5`

经过多少秒后，测试被视为慢速并在结果中报告为慢速。

### `snapshotFormat` [object]

默认：`{escapeString: false, printBasicPrototype: false}`

允许覆盖 格式漂亮的自述文件 中记录的特定快照格式选项，但 `compareKeys` 和 `plugins` 除外。例如，此配置将使快照格式化程序不打印 "目的" 和 "数组" 的前缀：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  snapshotFormat: {
    printBasicPrototype: false,
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  snapshotFormat: {
    printBasicPrototype: false,
  },
};

export default config;

```

some.test.js

```
test('does not show prototypes for object and array inline', () => {
  const object = {
    array: [{hello: 'Danger'}],
  };
  expect(object).toMatchInlineSnapshot(`
    {
      "array": [
        {
          "hello": "Danger",
        },
      ],
    }
  `);
});

```

### `snapshotResolver` [string]

默认：`undefined`

可以解析 test<->snapshot 路径的模块路径。此配置选项允许你自定义 Jest 在磁盘上存储快照文件的位置。

custom-resolver.js

```
module.exports = {
  // resolves from test to snapshot path
  resolveSnapshotPath: (testPath, snapshotExtension) =>
    testPath.replace('__tests__', '__snapshots__') + snapshotExtension,

  // resolves from snapshot to test path
  resolveTestPath: (snapshotFilePath, snapshotExtension) =>
    snapshotFilePath
      .replace('__snapshots__', '__tests__')
      .slice(0, -snapshotExtension.length),

  // Example test path, used for preflight consistency check of the implementation above
  testPathForConsistencyCheck: 'some/__tests__/example.test.js',
};

```

### `snapshotSerializers` [array<string>]

默认：`[]`

Jest 用于快照测试的快照序列化器模块的路径列表。

Jest 具有用于内置 JavaScript 类型、HTML 元素 (Jest 20.0.0+)、ImmutableJS (Jest 20.0.0+) 和 React 元素的默认序列化器。请参阅 快照测试教程 了解更多信息。

custom-serializer.js

```
module.exports = {
  serialize(val, config, indentation, depth, refs, printer) {
    return `Pretty foo: ${printer(val.foo)}`;
  },

  test(val) {
    return val && Object.prototype.hasOwnProperty.call(val, 'foo');
  },
};

```

`printer` 是一个使用现有插件序列化值的函数。

将 `custom-serializer` 添加到你的 Jest 配置中：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  snapshotSerializers: ['path/to/custom-serializer.js'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  snapshotSerializers: ['path/to/custom-serializer.js'],
};

export default config;

```

最后测试如下：

```
test(() => {
  const bar = {
    foo: {
      x: 1,
      y: 2,
    },
  };

  expect(bar).toMatchSnapshot();
});

```

渲染快照：

```
Pretty foo: Object {
  "x": 1,
  "y": 2,
}

```

提示

要使依赖显式而不是隐式，你可以调用 expect.addSnapshotSerializer 为单个测试文件添加模块，而不是在 Jest 配置中将其路径添加到 `snapshotSerializers`。

有关序列化器 API 的更多信息，请参阅 此处。

### `testEnvironment` [string]

默认：`"node"`

将用于测试的测试环境。Jest 中的默认环境是 Node.js 环境。如果你正在构建 Web 应用，则可以通过 jsdom 使用类似浏览器的环境。

通过在文件顶部添加 `@jest-environment` 文档块，你可以指定用于该文件中所有测试的另一个环境：

```
/**

 * @jest-environment jsdom
 */

test('use jsdom in this test file', () => {
  const element = document.createElement('div');
  expect(element).not.toBeNull();
});

```

你可以创建自己的模块，用于设置测试环境。该模块必须导出具有 `setup`、`teardown` 和 `getVmContext` 方法的类。你还可以通过将变量分配给 `this.global` 对象来将变量从该模块传递到你的测试套件 - 这将使它们在你的测试套件中作为全局变量可用。构造函数传递 globalConfig 和 projectConfig 作为其第一个参数，testEnvironmentContext 作为其第二个参数。

该类可以选择公开一个异步 `handleTestEvent` 方法来绑定到 jest-circus 触发的事件。通常，`jest-circus` 测试运行程序会暂停，直到 `handleTestEvent` 返回的 promise 得到履行，但以下事件除外：`start_describe_definition`、`finish_describe_definition`、`add_hook`、`add_test` 或 `error`（有关最新列表，你可以查看 类型定义中的 SyncEvent 类型）。这是由向后兼容性原因和 `process.on('unhandledRejection', callback)` 签名引起的，但这对于大多数用例来说通常不应该成为问题。

测试文件中的任何 docblock 编译指示都将传递给环境构造函数，并可用于每个测试配置。如果该编译指示没有值，它将出现在对象中，并将其值设置为空字符串。如果该编译指示不存在，则它不会出现在对象中。

要将此类用作你的自定义环境，请通过其在项目中的完整路径来引用它。例如，如果你的类存储在项目的某个子文件夹中的 `my-custom-environment.js` 中，则注释可能如下所示：

```
/**

 * @jest-environment ./src/test/my-custom-environment
 */

```

信息

测试环境是沙盒的。每个测试套件将在自己的测试环境中触发设置/拆卸。

示例：

```
// my-custom-environment
const NodeEnvironment = require('jest-environment-node').TestEnvironment;

class CustomEnvironment extends NodeEnvironment {
  constructor(config, context) {
    super(config, context);
    console.log(config.globalConfig);
    console.log(config.projectConfig);
    this.testPath = context.testPath;
    this.docblockPragmas = context.docblockPragmas;
  }

  async setup() {
    await super.setup();
    await someSetupTasks(this.testPath);
    this.global.someGlobalObject = createGlobalObject();

    // Will trigger if docblock contains @my-custom-pragma my-pragma-value
    if (this.docblockPragmas['my-custom-pragma'] === 'my-pragma-value') {
      // ...
    }
  }

  async teardown() {
    this.global.someGlobalObject = destroyGlobalObject();
    await someTeardownTasks();
    await super.teardown();
  }

  getVmContext() {
    return super.getVmContext();
  }

  async handleTestEvent(event, state) {
    if (event.name === 'test_start') {
      // ...
    }
  }
}

module.exports = CustomEnvironment;

```

```
// my-test-suite
/**

 * @jest-environment ./my-custom-environment
 */
let someGlobalObject;

beforeAll(() => {
  someGlobalObject = globalThis.someGlobalObject;
});

```

### `testEnvironmentOptions` [Object]

默认：`{}`

将传递给 `testEnvironment` 的测试环境选项。相关选项取决于环境。

例如，你可以覆盖传递给 jsdom 的选项：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  testEnvironment: 'jsdom',
  testEnvironmentOptions: {
    html: '<html lang="zh-cmn-Hant"></html>',
    url: 'https://jest.nodejs.cn/',
    userAgent: 'Agent/007',
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  testEnvironment: 'jsdom',
  testEnvironmentOptions: {
    html: '<html lang="zh-cmn-Hant"></html>',
    url: 'https://jest.nodejs.cn/',
    userAgent: 'Agent/007',
  },
};

export default config;

```

`jest-environment-jsdom` 和 `jest-environment-node` 都允许指定 `customExportConditions`，这允许你控制从 `exports` 加载到 `package.json` 的库版本。`jest-environment-jsdom` 默认为 `['browser']`。`jest-environment-node` 默认为 `['node', 'node-addons']`。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  testEnvironment: 'jsdom',
  testEnvironmentOptions: {
    customExportConditions: ['react-native'],
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  testEnvironment: 'jsdom',
  testEnvironmentOptions: {
    customExportConditions: ['react-native'],
  },
};

export default config;

```

这些选项也可以在文档块中传递，类似于 `testEnvironment`。带选项的字符串必须可由 `JSON.parse` 解析：

```
/**

 * @jest-environment jsdom

 * @jest-environment-options {"url": "https://jest.nodejs.cn/"}
 */

test('use jsdom and set the URL in this test file', () => {
  expect(window.location.href).toBe('https://jest.nodejs.cn/');
});

```

### `testFailureExitCode` [number]

默认：`1`

测试失败时返回退出代码 Jest。

信息

在出现 Jest 错误（例如无效配置）的情况下，这不会更改退出代码。

### `testMatch` [string | array<string>]

（默认：`[ "**/__tests__/**/*.?([mc])[jt]s?(x)", "**/?(*.)+(spec|test).?([mc])[jt]s?(x)" ]`）

Jest 用于检测测试文件的 glob 模式。默认情况下，它会查找 `__tests__` 文件夹内的 `.js`、`.jsx`、`.ts` 和 `.tsx` 文件，以及任何带有 `.test` 或 `.spec` 后缀的文件（例如 `Component.test.js` 或 `Component.spec.js`）。它还会查找名为 `test.js` 或 `spec.js` 的文件。

有关你可以指定的模式的详细信息，请参阅 micromatch 包。

另请参见 testRegex [string | array<string>]，但请注意你不能同时指定这两个选项。

提示

每个 glob 模式都按照它们在配置中指定的顺序应用。例如，`["!**/__fixtures__/**", "**/__tests__/**/*.js"]` 不会排除 `__fixtures__`，因为否定被第二个模式覆盖。为了使本例中的否定 glob 起作用，它必须位于 `**/__tests__/**/*.js` 之后。

### `testPathIgnorePatterns` [array<string>]

默认：`["/node_modules/"]`

在执行测试之前与所有测试路径进行匹配的正则表达式模式字符串数组。如果测试路径与任何模式匹配，它将被跳过。

这些模式字符串与完整路径匹配。使用 `<rootDir>` 字符串标记包含项目根目录的路径，以防止项目意外忽略可能具有不同根目录的不同环境中的所有文件。示例：`["<rootDir>/build/", "<rootDir>/node_modules/"]`。

### `testRegex` [string | array<string>]

默认：`(/__tests__/.*|(\\.|/)(test|spec))\\.[mc]?[jt]sx?$`

Jest 用于检测测试文件的一个或多个模式。默认情况下，它会查找 `__tests__` 文件夹内的 `.js`、`.jsx`、`.ts` 和 `.tsx` 文件，以及任何带有 `.test` 或 `.spec` 后缀的文件（例如 `Component.test.js` 或 `Component.spec.js`）。它还会查找名为 `test.js` 或 `spec.js` 的文件。另请参见 testMatch [string | array<string>]，但请注意你不能同时指定这两个选项。

以下是默认正则表达式的可视化：

```
├── __tests__
│   └── component.spec.js # test
│   └── anything # test
├── package.json # not test
├── foo.test.js # test
├── bar.spec.jsx # test
└── component.js # not test

```

信息

`testRegex` 将尝试使用绝对文件路径检测测试文件，因此，拥有与其名称匹配的文件夹将运行所有文件作为测试。

### `testResultsProcessor` [string]

默认：`undefined`

此选项允许使用自定义结果处理器。该处理器必须是一个节点模块，该模块导出一个函数，该函数需要具有以下结构的对象作为第一个参数并返回它：

```
{
  "success": boolean,
  "startTime": epoch,
  "numTotalTestSuites": number,
  "numPassedTestSuites": number,
  "numFailedTestSuites": number,
  "numRuntimeErrorTestSuites": number,
  "numTotalTests": number,
  "numPassedTests": number,
  "numFailedTests": number,
  "numPendingTests": number,
  "numTodoTests": number,
  "openHandles": Array<Error>,
  "testResults": [{
    "numFailingTests": number,
    "numPassingTests": number,
    "numPendingTests": number,
    "testResults": [{
      "title": string (message in it block),
      "status": "failed" | "pending" | "passed",
      "ancestorTitles": [string (message in describe blocks)],
      "failureMessages": [string],
      "numPassingAsserts": number,
      "location": {
        "column": number,
        "line": number
      },
      "duration": number | null,
      "startAt": epoch | null
    },
    ...
    ],
    "perfStats": {
      "end": epoch,
      "loadTestEnvironmentEnd": epoch,
      "loadTestEnvironmentStart": epoch,
      "runtime": number,
      "setupAfterEnvEnd": epoch,
      "setupAfterEnvStart": epoch,
      "setupFilesEnd": epoch,
      "setupFilesStart": epoch,
      "slow": boolean,
      "start": epoch
    },
    "testFilePath": absolute path to test file,
    "coverage": {}
  },
  "testExecError:" (exists if there was a top-level failure) {
    "message": string
    "stack": string
  }
  ...
  ]
}

```

`testResultsProcessor` 和 `reporters` 彼此非常相似。一个区别是测试结果处理器仅在所有测试完成后才会被调用。而报告者有能力在单个测试和/或测试套件完成后接收测试结果。

### `testRunner` [string]

默认：`jest-circus/runner`

此选项允许使用自定义测试运行程序。默认为 `jest-circus`。可以通过指定测试运行器实现的路径来提供自定义测试运行器。

测试运行器模块必须导出具有以下签名的函数：

```
function testRunner(
  globalConfig: GlobalConfig,
  config: ProjectConfig,
  environment: Environment,
  runtime: Runtime,
  testPath: string,
): Promise<TestResult>;

```

此类函数的示例可以在我们的默认 jasmine2 测试运行程序包.h 中找到。

### `testSequencer` [string]

默认：`@jest/test-sequencer`

此选项允许你使用自定义定序器而不是 Jest 的默认定序器。

提示

`sort` 和 `shard` 都可以选择返回 `Promise`。

例如，你可以按字母顺序对测试路径进行排序：

custom-sequencer.js

```
const Sequencer = require('@jest/test-sequencer').default;

class CustomSequencer extends Sequencer {
  /**

   * Select tests for shard requested via --shard=shardIndex/shardCount

   * Sharding is applied before sorting
   */
  shard(tests, {shardIndex, shardCount}) {
    const shardSize = Math.ceil(tests.length / shardCount);
    const shardStart = shardSize * (shardIndex - 1);
    const shardEnd = shardSize * shardIndex;

    return [...tests]
      .sort((a, b) => (a.path > b.path ? 1 : -1))
      .slice(shardStart, shardEnd);
  }

  /**

   * Sort test to determine order of execution

   * Sorting is applied after sharding
   */
  sort(tests) {
    // Test structure information
    // https://github.com/jestjs/jest/blob/6b8b1404a1d9254e7d5d90a8934087a9c9899dab/packages/jest-runner/src/types.ts#L17-L21
    const copyTests = [...tests];
    return copyTests.sort((testA, testB) => (testA.path > testB.path ? 1 : -1));
  }
}

module.exports = CustomSequencer;

```

将 `custom-sequencer` 添加到你的 Jest 配置中：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  testSequencer: 'path/to/custom-sequencer.js',
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  testSequencer: 'path/to/custom-sequencer.js',
};

export default config;

```

### `testTimeout` [number]

默认：`5000`

测试的默认超时（以毫秒为单位）。

### `transform` [object<string, pathToTransformer | [pathToTransformer, object]>]

默认：`{"\\.[jt]sx?$": "babel-jest"}`

从正则表达式到转换器路径的映射。或者，可以将带有配置选项的元组作为第二个参数传递：`{filePattern: ['path-to-transformer', {options}]}`。例如，以下是如何配置 `babel-jest` 以实现非默认行为：`{'\\.js$': ['babel-jest', {rootMode: 'upward'}]}`。

Jest 将项目代码作为 JavaScript 运行，因此如果你使用 Node 不支持的某些语法（例如 JSX、TypeScript、Vue 模板），则需要转换器。默认情况下，Jest 将使用 babel-jest 转换器，它将加载项目的 Babel 配置并转换与 `/\.[jt]sx?$/` RegExp 匹配的任何文件（换句话说，任何 `.js`、`.jsx`、`.ts` 或 `.tsx` 文件）。另外，`babel-jest` 将注入 ES 模块模拟 中谈到的模拟提升所需的 Babel 插件。

有关构建你自己的转换器的更多详细信息和说明，请参阅 代码转换 部分。

提示

请记住，除非文件已更改，否则转换器仅对每个文件运行一次。

如果你希望将默认的 `babel-jest` 转换器与其他代码预处理器一起使用，请记住显式包含它：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  transform: {
    '\\.[jt]sx?$': 'babel-jest',
    '\\.css$': 'some-css-transformer',
  },
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  transform: {
    '\\.[jt]sx?$': 'babel-jest',
    '\\.css$': 'some-css-transformer',
  },
};

export default config;

```

### `transformIgnorePatterns` [array<string>]

默认：`["/node_modules/", "\\.pnp\\.[^\\\/]+$"]`

正则表达式模式字符串数组，在转换之前与所有源文件路径进行匹配。如果文件路径与任何模式匹配，则不会对其进行转换。

提供相互重叠的正则表达式模式可能会导致你期望转换的文件没有被转换。例如：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  transformIgnorePatterns: ['/node_modules/(?!(foo|bar)/)', '/bar/'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  transformIgnorePatterns: ['/node_modules/(?!(foo|bar)/)', '/bar/'],
};

export default config;

```

第一个模式将匹配（因此不转换）`/node_modules` 内的文件，`/node_modules/foo/` 和 `/node_modules/bar/` 中的文件除外。第二个模式将匹配（因此不会转换）任何包含 `/bar/` 的路径内的文件。将两者结合在一起时，`/node_modules/bar/` 中的文件将不会被转换，因为它确实与第二个模式匹配，即使它被第一个模式排除了。

有时（尤其是在 React Native 或 TypeScript 项目中），第 3 方模块会作为未转译的代码发布。由于 `node_modules` 内的所有文件默认都不会被转换，Jest 将无法理解这些模块中的代码，从而导致语法错误。为了克服这个问题，你可以使用 `transformIgnorePatterns` 来允许转译此类模块。你将在 React Native 指南 中找到此用例的一个很好的示例。

这些模式字符串与完整路径匹配。使用 `<rootDir>` 字符串标记包含项目根目录的路径，以防止项目意外忽略可能具有不同根目录的不同环境中的所有文件。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  transformIgnorePatterns: [
    '<rootDir>/bower_components/',
    '<rootDir>/node_modules/',
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  transformIgnorePatterns: [
    '<rootDir>/bower_components/',
    '<rootDir>/node_modules/',
  ],
};

export default config;

```

提示

如果你使用 `pnpm`，需要转换 `node_modules` 下的一些包，需要注意的是，该文件夹下的包（如 `node_modules/package-a/`）已经符号链接到了 `.pnpm` 下的路径（如 `node_modules/.pnpm/package-a@x.x.x/node_modules/package-a/`），所以直接使用 `<rootDir>/node_modules/(?!(package-a|@scope/pkg-b)/)` 将无法被识别，而 是使用：

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  transformIgnorePatterns: [
    '<rootDir>/node_modules/.pnpm/(?!(package-a|@scope\\+pkg-b)@)',
    /* if config file is under '~/packages/lib-a/' */
    `${path.join(
      __dirname,
      '../..',
    )}/node_modules/.pnpm/(?!(package-a|@scope\\+pkg-b)@)`,
    /* or using relative pattern to match the second 'node_modules/' in 'node_modules/.pnpm/@scope+pkg-b@x.x.x/node_modules/@scope/pkg-b/' */
    'node_modules/(?!.pnpm|package-a|@scope/pkg-b)',
  ],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  transformIgnorePatterns: [
    '<rootDir>/node_modules/.pnpm/(?!(package-a|@scope\\+pkg-b)@)',
    /* if config file is under '~/packages/lib-a/' */
    `${path.join(
      __dirname,
      '../..',
    )}/node_modules/.pnpm/(?!(package-a|@scope\\+pkg-b)@)`,
    /* or using relative path to match the second 'node_modules/' in 'node_modules/.pnpm/@scope+pkg-b@x.x.x/node_modules/@scope/pkg-b/' */
    'node_modules/(?!.pnpm|package-a|@scope/pkg-b)',
  ],
};

export default config;

```

需要注意的是，`.pnpm` 下的 pnpm 的文件夹名称是包名加上 `@` 和版本号，所以写 `/` 不会被识别，但使用 `@` 可以。

### `unmockedModulePathPatterns` [array<string>]

默认：`[]`

在模块加载器之前与所有模块匹配的正则表达式模式字符串数组将自动返回它们的模拟。如果模块的路径与此列表中的任何模式匹配，则模块加载器不会自动模拟它。

这对于一些几乎总是用作实现细节的常用 'utility' 模块很有用（如 `underscore`、`lodash` 等）。通常，最佳实践是保持此列表尽可能小，并在单独的测试中始终使用显式 `jest.mock()`/`jest.unmock()` 调用。对于测试的其他读者来说，显式的每个测试设置更容易推断测试将运行的环境。

通过在测试文件顶部显式调用 `jest.mock()` ，可以在各个测试中覆盖此设置。

### `verbose` [boolean]

默认：如果只有一个测试文件要运行，则为 `false` 或 `true`

指示是否应在运行期间报告每个单独的测试。执行后所有错误仍将显示在底部。

### `waitForUnhandledRejections` [boolean]

提供一个事件循环来处理 `rejectionHandled`、`uncaughtException` 或 `unhandledRejection`。

如果没有此标志，Jest 可能会报告误报错误（例如，报告了实际已处理的拒绝）或不报告实际未处理的拒绝（或报告不同的测试用例）。

此选项可能会给快速测试套件增加明显的开销。

### `watchPathIgnorePatterns` [array<string>]

默认：`[]`

在监视模式下重新运行测试之前与所有源文件路径进行匹配的 RegExp 模式数组。如果文件路径与任何模式匹配，则更新时不会触发重新运行测试。

这些模式与完整路径匹配。使用 `<rootDir>` 字符串标记包含项目根目录的路径，以防止项目意外忽略可能具有不同根目录的不同环境中的所有文件。示例：`["<rootDir>/node_modules/"]`。

即使此处未指定任何内容，观察程序也会忽略对版本控制文件夹（.git、.hg、.sl）的更改。默认情况下会监视其他隐藏文件和目录，即以点 (`.`) 开头的文件和目录。当你将它们添加到 `watchPathIgnorePatterns` 时，请记住转义点，因为它是特殊的 RegExp 字符。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  watchPathIgnorePatterns: ['<rootDir>/\\.tmp/', '<rootDir>/bar/'],
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  watchPathIgnorePatterns: ['<rootDir>/\\.tmp/', '<rootDir>/bar/'],
};

export default config;

```

### `watchPlugins` [array<string | [string, Object]>]

默认：`[]`

此选项允许你使用自定义监视插件。了解有关监视插件 此处 的更多信息。

监视插件的示例包括：

* jest-watch-master
* jest-watch-select-projects
* jest-watch-suspend
* jest-watch-typeahead
* jest-watch-yarn-workspaces

信息

`watchPlugins` 属性值中的值可以省略包名称的 `jest-watch-` 前缀。

### `watchman` [boolean]

默认：`true`

是否使用 watchman 进行文件抓取。

### `workerIdleMemoryLimit` [number|string]

默认：`undefined`

指定工作线程在回收之前的内存限制，主要是 这个问题 的解决方法；

工作进程执行测试后，将检查其内存使用情况。如果超过指定的值，工作线程将被终止并重新启动。可以通过多种不同的方式指定限制，无论结果是什么 `Math.floor` 都用于将其转换为整数值：

* `<= 1` \- 该值假定为系统内存的百分比。所以 0.5 将 worker 的内存限制设置为系统总内存的一半  
* `\> 1` \- 假设是固定字节值。由于之前的规则，如果你想要 1 字节的值（我不知道为什么），你可以使用 `1.1`。  
* 有单位  
   * `50%` \- 如上，占系统总内存的百分比  
   ¥`50%` \- As above, a percentage of total system memory  
   * `100KB`、`65MB` 等 - 用单位表示固定的内存限制。  
   ¥`100KB`, `65MB`, etc - With units to denote a fixed memory limit.  
         * `K` / `KB` \- 千字节 (x1000)  
         ¥`K` / `KB` \- Kilobytes (x1000)  
         * `KiB` \- 千字节 (x1024)  
         ¥`KiB` \- Kibibytes (x1024)  
         * `M` / `MB` \- 兆字节  
         ¥`M` / `MB` \- Megabytes  
         * `MiB` \- 兆字节  
         ¥`MiB` \- Mebibytes  
         * `G` / `GB` \- 千兆字节  
         ¥`G` / `GB` \- Gigabytes  
         * `GiB` \- 千兆字节  
         ¥`GiB` \- Gibibytes

提醒

由于报告的系统内存不正确，导致基于百分比的内存限制 不适用于 Linux CircleCI 工作线程。

* JavaScript
* TypeScript

```
/** @type {import('jest').Config} */
const config = {
  workerIdleMemoryLimit: 0.2,
};

module.exports = config;

```

```
import type {Config} from 'jest';

const config: Config = {
  workerIdleMemoryLimit: 0.2,
};

export default config;

```

### `//` [string]

该选项允许在 `package.json` 中的注释。包含注释文本作为该键的值：

package.json

```
{
  "name": "my-project",
  "jest": {
    "//": "Comment goes here",
    "verbose": true
  }
}

```

### `workerThreads`

默认：`false`

是否使用 工作线程 进行并行化。默认使用 子进程。

使用工作线程可能有助于改进 performance。

提醒

这是实验性功能。请记住，工作线程使用结构化克隆而不是 `JSON.stringify()` 来序列化消息。这意味着 `BigInt`、`Map` 或 `Set` 等内置 JavaScript 对象将被正确序列化。但是，在 `Error`、`Map` 或 `Set` 上设置的额外属性将不会通过序列化步骤传递。有关更多详细信息，请参阅有关 结构化克隆 的文章。
