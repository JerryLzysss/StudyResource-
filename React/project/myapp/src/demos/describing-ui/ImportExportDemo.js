function Profile() {
  return (
    <img
      className="avatar"
      src="https://react.dev/images/docs/scientists/QIrZWGIs.jpg"
      alt="Alan L. Hart"
    />
  );
}

function Gallery() {
  return (
    <section>
      <h3>Amazing scientists</h3>
      <div className="avatar-row">
        <Profile />
        <Profile />
        <Profile />
      </div>
      <p className="demo-note">演示：Gallery 组合多个 Profile（等价于多文件导入导出）。</p>
    </section>
  );
}

export default function ImportExportDemo() {
  return <Gallery />;
}
