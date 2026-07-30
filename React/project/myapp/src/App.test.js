import { render, screen } from '@testing-library/react';
import App from './App';

test('renders learning home title', () => {
  render(<App />);
  const titleElement = screen.getByText(/React 学习路由总览/i);
  expect(titleElement).toBeInTheDocument();
});
