import { Link, useParams } from 'react-router-dom';
import { findChapter } from '../lessons';

export default function ChapterPage() {
  const { chapterId } = useParams();
  const chapter = findChapter(chapterId);

  if (!chapter) {
    return (
      <div className="page">
        <h1>未找到该章节</h1>
        <Link to="/">返回首页</Link>
      </div>
    );
  }

  return (
    <div className="page">
      <h1>{chapter.title}</h1>
      <p>选择一个小节开始学习：</p>
      <ul className="lesson-list">
        {chapter.lessons.map((lesson) => (
          <li key={lesson.id}>
            <Link to={`${chapter.path}/${lesson.id}`}>{lesson.title}</Link>
            {lesson.Demo ? (
              <span className="tag demo">演示</span>
            ) : (
              <span className="tag text">文本</span>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}
