// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom/client'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import { ReactQueryDevtools } from '@tanstack/react-query-devtools'
import { Chart, registerables } from 'chart.js'

import App from '../components/App'

// Register chart.js parameters
Chart.register(...registerables);

// if (process.env.NODE_ENV === 'development') {
//     import('../mocks/browser')
//       .then(({ worker }) => {
//         worker.start({
//           serviceWorker: {
//             url: '/mockServiceWorker.js'
//           }
//         });
//       })
//       .catch(console.error);
// }

// QueryClient creation for React Query
const queryClient = new QueryClient({
    // do not refetch on window focus
    defaultOptions: {
      queries: {
        refetchOnWindowFocus: false,
        staleTime: 300_000 // cache data for 5 minutes
      }
    }
});

document.addEventListener('DOMContentLoaded', () => {
  const root = ReactDOM.createRoot(document.getElementById("root"));
  root.render(
    <React.StrictMode>
      <QueryClientProvider client={queryClient}>
        <App title="META-METRICS 📊" />
        <ReactQueryDevtools initialIsOpen={true} />
      </QueryClientProvider>
    </React.StrictMode>
  );
})
