import React, { useState, useEffect } from 'react';
import axios from 'axios';

const AxiosDemo = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get(
          'https://jsonplaceholder.typicode.com/posts/1'
        );
        setData(response.data);
        setLoading(false);
      } catch (err) {
        console.error('Error fetching data:', err);
        setError(err.message);
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) {
    return <div>Loading (axios)...</div>;
  }

  if (error) {
    return <div>Error (axios): {error}</div>;
  }

  return (
    <div>
      <h2>axios 请求示例</h2>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
};

export default AxiosDemo;
