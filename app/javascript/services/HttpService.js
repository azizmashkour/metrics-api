import { API } from '../constants'

/**
   * get or create metrics.
   *
   * @param {Object} data - The data object of a new creating metric.
   * @return {Promise} - Promise representing the result of the request.
   */
export async function fetchMetrics() {
  console.log('API.API_METRICS_URL', API)
  return await fetch(`${API.BASE_URL + API.METRICS_URL}`);
}