function AlertButton({ message, children }) {
  return (
    <button type="button" onClick={() => alert(message)}>
      {children}
    </button>
  );
}

export default function RespondingEventsDemo() {
  function handlePlayClick() {
    alert('正在播放！');
  }

  return (
    <section className="stack">
      <AlertButton message="正在上传！">上传图片</AlertButton>
      <button type="button" onClick={handlePlayClick}>
        播放电影
      </button>
      <button
        type="button"
        onClick={(e) => {
          e.stopPropagation();
          alert('已阻止冒泡');
        }}
      >
        阻止冒泡示例
      </button>
    </section>
  );
}
