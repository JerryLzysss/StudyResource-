export default function JsxMarkupDemo() {
  return (
    <>
      <h3>Hedy Lamarr&apos;s Todos</h3>
      <img
        className="avatar"
        src="https://react.dev/images/docs/scientists/yXOvdOSs.jpg"
        alt="Hedy Lamarr"
      />
      <ul>
        <li>Invent new traffic lights</li>
        <li>Rehearse a movie scene</li>
        <li>Improve spectrum technology</li>
      </ul>
      <p className="demo-note">注意：使用 className、自闭合标签、Fragment 包裹多个根节点。</p>
    </>
  );
}
