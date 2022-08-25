import React, { useRef, useEffect, useState, Fragment } from 'react'
import { jsonFetch, transformToChartJSFormat } from '../../lib/utils'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { Chart } from 'chart.js'

import {
  API_URL,
  NOT_FOUND_MSG,
  SUCCESS_MSG,
  CHART_METRIC_OPTIONS
} from '../../constants'
import Button from '../button/Button'

const Home = () => {
  const [message, setMessage] = useState(null);

  // query and mutation for metrics to get and add metrics
  const { data, isLoading } = useQuery(['metrics'], async () => {
    console.log('fetching...', data)
    return jsonFetch(API_URL).catch(
      () => {
        throw new Error(NOT_FOUND_MSG)
      }
    );
  });

  const queryClient = useQueryClient();
  const mutation = useMutation(
    async (data) => {
      return jsonFetch(API_URL, {
        method: 'POST',
        body: JSON.stringify({
          ...data,
          timestamp: data.date.toISOString()
        })
      });
    },
    {
      onSuccess() {
        queryClient.invalidateQueries(['metrics']);
        setMessage(SUCCESS_MSG);
      }
    }
  );

  // Refs For ChartJS
  const chartRef = useRef(null)
  const canvasRef = useRef(null)

  const buildChart = (ctx, data) => {
    const { labels, datasets } = transformToChartJSFormat(data)
    console.log({ labels, datasets })

    // find labels
    chartRef.current = new Chart(ctx, {
      type: 'bar',
      data: {
        labels,
        datasets
      },
      options: CHART_METRIC_OPTIONS
    });
  }

  useEffect(() => {
    const ctx = canvasRef.current?.getContext('2d');
    if (ctx && data !== undefined) buildChart(ctx, data)
    return () => {
      // destroy the chartRef on component unMount
      chartRef.current?.destroy()
    }
  }, [data])

  // Form handling states
  const [key, setKey] = useState('')
  const [name, setName] = useState('')
  const [value, setValue] = useState(0)
  const [date, setDate] = useState(new Date())

const handleAddMetric = () => {
      if (date) {
        mutation.mutate({
          name,
          key,
          value,
          date
        });
      } else {
        console.log({
          date
        });
      }
  }

  return (
    <Fragment>
      {isLoading ? (
        <div className='text-center'>
          <span>Loading metrics...</span>
        </div>
    ) :
      (
        <div className="grid grid-cols-12 space-x-6">
          <div className="col-span-3">
            <form
              className="flex flex-col gap-2"
              onSubmit={(ev) => {
                ev.preventDefault();
                handleAddMetric
              }}>
              {message && (
                <div className="bg-green-500/50 p-2 border border-green-500">
                  {message}&nbsp;
                  <button
                    className="p-2 text-lg text-gray-900 rounded-md"
                    onClick={() => setMessage(null)}>
                    X
                  </button>
                </div>
              )}
              <h3 className='text-2xl text-center mb-4'>Add a metric</h3>
              <input
                required
                type="text"
                value={key}
                onChange={(ev) => setKey(ev.target.value)}
                placeholder="key"
                className="p-2 rounded-md border"
              />
              <input
                required
                type="text"
                value={name}
                onChange={(ev) => setName(ev.target.value)}
                placeholder="name"
                className="p-2 rounded-md border"
              />
              <input
                required
                type="number"
                value={value}
                onChange={(ev) => setValue(ev.target.valueAsNumber)}
                placeholder="value"
                className="p-2 rounded-md border"
              />
              <input
                required
                type="datetime-local"
                onChange={(ev) =>
                  setDate(new Date(ev.target.value))
                }
                placeholder="date"
                className="p-2 rounded-md border"
              />
              <Button type="submit" disabled={mutation.isLoading}>
                {mutation.isLoading
                  ? 'Submitting...'
                  : 'Save metric'}
              </Button>
            </form>
          </div>
          <div className='col-span-9'>
            <canvas id="myChart" ref={canvasRef} />
          </div>
        </div>
      )}
    </Fragment>
  )
};

export default Home;
