import uniqolor from 'uniqolor'

export  const jsonFetch = async (url, options) => {
  // Set the default headers correctly
  const headers = new Headers();
  headers.set('Accept', 'application/json');
  headers.set('Content-Type', 'application/json');

  if (process.env.NODE_ENV === 'development') {
    // in dev mode, simulate a loading time
    await wait(1500);
  }

  return fetch(url, {
    ...options,
    headers,
    credentials: 'include'
  })
    .then((response) => response.json())
    .catch((error) => {
      console.error('There was an error ?', error);
    });
}

// Wait for the specified amount of time
export const wait = (time) => new Promise((resolve) => setTimeout(resolve, time))

export const formatDate = (date) => {
  return `${(date.getMonth() + 1)
    .toString()
    .padStart(2, '0')}/${date
    .getDate()
    .toString()
    .padStart(2, '0')}`;
}

const sortMetrics = (metrics) =>
  metrics.sort((a, b) => {
    const dateA = new Date(a.timestamp);
    const dateB = new Date(b.timestamp);
 
    if (dateA > dateB) {
      return 1;
    } else if (dateA < dateB) {
      return -1;
    } else {
      return 0;
    }
  });

// Group by dates to haves labels shown in the X axis in format 'dd/MM'
const buildLabelsForMetricChart = (sorted, metrics) => {
  const labels = [];

  for (let i = 0; i < metrics.length; i++) {
    const currentMetric = sorted[i];
    const date = new Date(currentMetric.timestamp);
    const dateStr = formatDate(date);
    if (!labels.includes(dateStr)) {
      labels.push(dateStr);
    }
  }
  return labels
}

// Group datasets by metrics
const buildDatasetsForMetric = (sorted) => {
  const datasetsByKey = {};

  for (let i = 0; i < sorted.length; i++) {
    const currentMetric = sorted[i];
    const dateKey = formatDate(new Date(currentMetric.timestamp));

    if (currentMetric.name in datasetsByKey) {
      const oldData = datasetsByKey[currentMetric.name].data;

      // sum metrics that happenned the same day
      if (dateKey in oldData) {
        oldData[dateKey] += currentMetric.value;
      } else {
        oldData[dateKey] = currentMetric.value;
      }
    } else {
      datasetsByKey[currentMetric.name] = {
        label: currentMetric.name,
        data: {
          [dateKey]: currentMetric.value
        }
      };
    }
  }
  return datasetsByKey
}


/**
* Transform metrics got from the `Api` to chartjs data
* @param metrics
* @returns
*/
export function transformToChartJSFormat(metrics) {
 const sorted = sortMetrics(metrics)
 const labels = buildLabelsForMetricChart(sorted, metrics)
 const datasetsByKey = buildDatasetsForMetric(sorted)

 // Convert to chart.js datasets
 const datasets = [];
 for (const key in datasetsByKey) {
   const data = [];
   // fill all the data of the same dataset with the same color
   const borderColor = Array.from(
     { length: labels.length },
     () => uniqolor(key).color
   );
   const backgroundColor = Array.from(
     { length: labels.length },
     () => uniqolor(key, { format: 'rgb', lightness: 80 }).color
   );
   const metric = datasetsByKey[key];

   for (const label of labels) {
     if (label in metric.data) {
       data.push(metric.data[label]);
     } else {
       data.push(0);
     }
   }

   datasets.push({
     label: key,
     data,
     borderColor,
     backgroundColor,
     borderWidth: 1
   });
 }

 return {
   labels,
   datasets
 };
}