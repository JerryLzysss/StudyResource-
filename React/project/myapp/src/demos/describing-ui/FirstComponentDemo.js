function Profile() {
  return (
    <img
      className="avatar"
      src="https://react.dev/images/docs/scientists/MK3eW3As.jpg"
      alt="Katherine Johnson"
    />
  );
}

export default function FirstComponentDemo() {
  return (
    <section>
      <h3>Amazing scientists</h3>
      <div className="avatar-row">
        <Profile />
        <Profile />
        <Profile />
      </div>
    </section>
  );
}
