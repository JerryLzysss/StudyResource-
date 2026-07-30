import FirstComponentDemo from './demos/describing-ui/FirstComponentDemo';
import ImportExportDemo from './demos/describing-ui/ImportExportDemo';
import JsxMarkupDemo from './demos/describing-ui/JsxMarkupDemo';
import CurlyBracesDemo from './demos/describing-ui/CurlyBracesDemo';
import PropsDemo from './demos/describing-ui/PropsDemo';
import ConditionalDemo from './demos/describing-ui/ConditionalDemo';
import RenderingListsDemo from './demos/describing-ui/RenderingListsDemo';
import PureComponentDemo from './demos/describing-ui/PureComponentDemo';

import RespondingEventsDemo from './demos/adding-interactivity/RespondingEventsDemo';
import StateMemoryDemo from './demos/adding-interactivity/StateMemoryDemo';
import StateSnapshotDemo from './demos/adding-interactivity/StateSnapshotDemo';
import QueueingUpdatesDemo from './demos/adding-interactivity/QueueingUpdatesDemo';
import UpdatingObjectsDemo from './demos/adding-interactivity/UpdatingObjectsDemo';
import UpdatingArraysDemo from './demos/adding-interactivity/UpdatingArraysDemo';

import ReactingInputDemo from './demos/managing-state/ReactingInputDemo';
import ChoosingStructureDemo from './demos/managing-state/ChoosingStructureDemo';
import SharingStateDemo from './demos/managing-state/SharingStateDemo';
import PreservingStateDemo from './demos/managing-state/PreservingStateDemo';
import ReducerDemo from './demos/managing-state/ReducerDemo';
import ContextDemo from './demos/managing-state/ContextDemo';
import ReducerContextDemo from './demos/managing-state/ReducerContextDemo';

export const chapters = [
  {
    id: 'describing-ui',
    title: '描述 UI',
    path: '/describing-ui',
    contentDir: 'describing-ui',
    lessons: [
      {
        id: 'overview',
        title: '描述 UI（总览）',
        md: '00-描述UI.md',
      },
      {
        id: 'first-component',
        title: '你的第一个组件',
        md: '01-你的第一个组件.md',
        Demo: FirstComponentDemo,
      },
      {
        id: 'import-export',
        title: '组件的导入与导出',
        md: '02-组件的导入与导出.md',
        Demo: ImportExportDemo,
      },
      {
        id: 'jsx-markup',
        title: '使用 JSX 书写标签语言',
        md: '03-使用JSX书写标签语言.md',
        Demo: JsxMarkupDemo,
      },
      {
        id: 'curly-braces',
        title: '在 JSX 中通过大括号使用 JavaScript',
        md: '04-在JSX中通过大括号使用JavaScript.md',
        Demo: CurlyBracesDemo,
      },
      {
        id: 'props',
        title: '将 Props 传递给组件',
        md: '05-将Props传递给组件.md',
        Demo: PropsDemo,
      },
      {
        id: 'conditional',
        title: '条件渲染',
        md: '06-条件渲染.md',
        Demo: ConditionalDemo,
      },
      {
        id: 'lists',
        title: '渲染列表',
        md: '07-渲染列表.md',
        Demo: RenderingListsDemo,
      },
      {
        id: 'pure',
        title: '保持组件纯粹',
        md: '08-保持组件纯粹.md',
        Demo: PureComponentDemo,
      },
      {
        id: 'ui-tree',
        title: '将 UI 视为树',
        md: '09-将UI视为树.md',
      },
    ],
  },
  {
    id: 'adding-interactivity',
    title: '添加交互',
    path: '/adding-interactivity',
    contentDir: 'adding-interactivity',
    lessons: [
      {
        id: 'overview',
        title: '添加交互（总览）',
        md: '00-添加交互.md',
      },
      {
        id: 'events',
        title: '响应事件',
        md: '01-响应事件.md',
        Demo: RespondingEventsDemo,
      },
      {
        id: 'state-memory',
        title: 'state：组件的记忆',
        md: '02-state组件的记忆.md',
        Demo: StateMemoryDemo,
      },
      {
        id: 'render-commit',
        title: '渲染和提交',
        md: '03-渲染和提交.md',
      },
      {
        id: 'snapshot',
        title: 'state 如同一张快照',
        md: '04-state如同一张快照.md',
        Demo: StateSnapshotDemo,
      },
      {
        id: 'queueing',
        title: '把一系列 state 更新加入队列',
        md: '05-把一系列state更新加入队列.md',
        Demo: QueueingUpdatesDemo,
      },
      {
        id: 'objects',
        title: '更新 state 中的对象',
        md: '06-更新state中的对象.md',
        Demo: UpdatingObjectsDemo,
      },
      {
        id: 'arrays',
        title: '更新 state 中的数组',
        md: '07-更新state中的数组.md',
        Demo: UpdatingArraysDemo,
      },
    ],
  },
  {
    id: 'managing-state',
    title: '状态管理',
    path: '/managing-state',
    contentDir: 'managing-state',
    lessons: [
      {
        id: 'overview',
        title: '状态管理（总览）',
        md: '00-状态管理.md',
      },
      {
        id: 'reacting-input',
        title: '用 State 响应输入',
        md: '01-用State响应输入.md',
        Demo: ReactingInputDemo,
      },
      {
        id: 'structure',
        title: '选择 State 结构',
        md: '02-选择State结构.md',
        Demo: ChoosingStructureDemo,
      },
      {
        id: 'sharing',
        title: '在组件间共享状态',
        md: '03-在组件间共享状态.md',
        Demo: SharingStateDemo,
      },
      {
        id: 'preserving',
        title: '对 state 进行保留和重置',
        md: '04-对state进行保留和重置.md',
        Demo: PreservingStateDemo,
      },
      {
        id: 'reducer',
        title: '迁移状态逻辑至 Reducer',
        md: '05-迁移状态逻辑至Reducer中.md',
        Demo: ReducerDemo,
      },
      {
        id: 'context',
        title: '使用 Context 深层传递参数',
        md: '06-使用Context深层传递参数.md',
        Demo: ContextDemo,
      },
      {
        id: 'reducer-context',
        title: '使用 Reducer 和 Context 拓展应用',
        md: '07-使用Reducer和Context拓展你的应用.md',
        Demo: ReducerContextDemo,
      },
    ],
  },
];

export function findChapter(chapterId) {
  return chapters.find((c) => c.id === chapterId);
}

export function findLesson(chapterId, lessonId) {
  const chapter = findChapter(chapterId);
  if (!chapter) return null;
  return chapter.lessons.find((l) => l.id === lessonId) || null;
}
