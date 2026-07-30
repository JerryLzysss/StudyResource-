import { useState } from "react";
import { Link, useParams } from "react-router-dom";
import MarkdownPanel from "./MarkdownPanel";
import { findChapter, findLesson } from "../lessons";

export default function LessonPage() {
  const { chapterId, lessonId } = useParams();
  const chapter = findChapter(chapterId);
  const lesson = findLesson(chapterId, lessonId);
  const [showNotes, setShowNotes] = useState(!lesson?.Demo);

  if (!chapter || !lesson) {
    return (
      <div className="page">
        <h1>未找到该小节</h1>
        <Link to="/">返回首页</Link>
      </div>
    );
  }

  const Demo = lesson.Demo;
  const mdUrl = `${process.env.PUBLIC_URL}/content/${chapter.contentDir}/${encodeURIComponent(lesson.md)}`;

  return (
    <div className="page lesson-page">
      <div className="lesson-header">
        <p className="breadcrumb">
          <Link to="/">首页</Link>
          <span> / </span>
          <Link to={chapter.path}>{chapter.title}</Link>
          <span> / </span>
          <span>{lesson.title}</span>
        </p>
        <h1>{lesson.title}</h1>
        {Demo ? (
          <button
            type="button"
            className="toggle-notes"
            onClick={() => setShowNotes((v) => !v)}
          >
            {showNotes ? "隐藏笔记文本" : "查看笔记文本"}
          </button>
        ) : (
          <p className="hint">本小节以概念讲解为主，下方展示笔记原文。</p>
        )}
      </div>

      {Demo && (
        <section className="demo-section">
          <h2>可运行演示</h2>
          <div className="demo-box">
            <Demo />
          </div>
        </section>
      )}

      {(showNotes || !Demo) && (
        <section className="notes-section">
          <h2>笔记原文</h2>
          <MarkdownPanel url={mdUrl} />
        </section>
      )}
    </div>
  );
}