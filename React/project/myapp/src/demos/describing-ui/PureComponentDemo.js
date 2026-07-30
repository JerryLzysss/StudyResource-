function Cup({ guest }) {
  return <h3>Tea cup for guest #{guest}</h3>;
}

export default function PureComponentDemo() {
  return (
    <section>
      <p className="demo-note">
        纯组件：相同输入（guest）总是得到相同输出，不修改外部变量。
      </p>
      <Cup guest={1} />
      <Cup guest={2} />
      <Cup guest={3} />
    </section>
  );
}
