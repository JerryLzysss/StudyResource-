export interface NavItem {
  title: string;
  path: string;
  children?: NavItem[];
}

export const APP_NAV: NavItem[] = [
  {
    title: '简介',
    path: 'intro',
    children: [{ title: 'Angular 概览', path: 'intro/overview' }],
  },
  {
    title: '深度指南',
    path: 'guide',
    children: [
      { title: '信号', path: 'guide/signals' },
      { title: '组件', path: 'guide/components' },
      { title: '模板', path: 'guide/templates' },
      { title: '指令', path: 'guide/directives' },
      { title: '依赖注入', path: 'guide/dependency-injection' },
      { title: '路由', path: 'guide/routing' },
      { title: '表单', path: 'guide/forms' },
      { title: 'HTTP 客户端', path: 'guide/http-client' },
      { title: '延迟加载', path: 'guide/ssr' },
      { title: '测试', path: 'guide/testing' },
      { title: '国际化', path: 'guide/i18n' },
      { title: '动画', path: 'guide/animations' },
      { title: '拖放', path: 'guide/drag-drop' },
    ],
  },
  {
    title: '开发者工具',
    path: 'tools',
    children: [
      { title: 'Angular CLI', path: 'tools/cli' },
      { title: '库结构', path: 'tools/libraries' },
      { title: '组件检查器', path: 'tools/devtools' },
      { title: '语言服务', path: 'tools/language-service' },
    ],
  },
];
