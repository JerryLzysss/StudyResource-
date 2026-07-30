import { useState } from 'react';

export default function ReactingInputDemo() {
  const [answer, setAnswer] = useState('');
  const [error, setError] = useState(null);
  const [status, setStatus] = useState('typing');

  if (status === 'success') {
    return <h3>答对了！</h3>;
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setStatus('submitting');
    try {
      await submitForm(answer);
      setStatus('success');
    } catch (err) {
      setStatus('typing');
      setError(err);
    }
  }

  return (
    <section className="stack form-demo">
      <h3>城市测验</h3>
      <p>哪个城市有把空气变成饮用水的广告牌？</p>
      <form onSubmit={handleSubmit}>
        <textarea
          value={answer}
          onChange={(e) => setAnswer(e.target.value)}
          disabled={status === 'submitting'}
        />
        <br />
        <button
          type="submit"
          disabled={answer.length === 0 || status === 'submitting'}
        >
          Submit
        </button>
        {error && <p className="error-text">{error.message}</p>}
      </form>
    </section>
  );
}

function submitForm(answer) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      if (answer.toLowerCase() === 'lima') {
        resolve();
      } else {
        reject(new Error('猜错了，再试试！答案提示：Lima'));
      }
    }, 800);
  });
}
