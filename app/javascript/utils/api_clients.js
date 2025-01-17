import axios from 'axios';

import config from '@utils/config.js.erb';

import store from '@store/store';
import router from '@router/router';

/**
 * Create a new Axios client instance
 * @see https://github.com/mzabriskie/axios#creating-an-instance
 */
const initClient = (config) => {
  const evallyTokenKey = 'ev411y_t0k3n';
  const evallyLangKey = 'ev411y_l4ng';

  const getBaseUrl = () =>
    [config.host, localStorage.getItem(evallyLangKey) || 'en'].join('/');
  const getToken = () => localStorage.getItem(evallyTokenKey);

  const client = axios.create();

  // Add a request interceptor
  client.interceptors.request.use(
    (requestConfig) => {
      const options = {
        baseURL: getBaseUrl(),
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json',
          Authorization: `Basic ${btoa(config.basicAuth)}`,
          Token: getToken(),
        },
      };

      return { ...requestConfig, ...options };
    },
    (requestError) => {
      // Raven.captureException(requestError)

      return Promise.reject(requestError);
    },
  );

  // Add a response interceptor
  client.interceptors.response.use(
    (response) => response,
    (error) => {
      switch (error.response.status) {
        case 401:
          store.dispatch('AuthenticationModule/logout');

          router.push({ name: 'login_path' });
          break;
        case 403:
        case 404:
          router.push({ name: 'dashboard_path' });
          break;
        case 422:
          break;
        default:
        // Raven.captureException(error)
      }

      return Promise.reject(error);
    },
  );

  return client;
};

class ApiClient {
  constructor(config) {
    this.client = initClient(config);
  }

  get(url, conf = {}) {
    return this.client
      .get(url, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  delete(url, conf = {}) {
    return this.client
      .delete(url, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  head(url, conf = {}) {
    return this.client
      .head(url, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  options(url, conf = {}) {
    return this.client
      .options(url, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  post(url, data = {}, conf = {}) {
    return this.client
      .post(url, data, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  put(url, data = {}, conf = {}) {
    return this.client
      .put(url, data, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }

  patch(url, data = {}, conf = {}) {
    return this.client
      .patch(url, data, conf)
      .then((response) => Promise.resolve(response))
      .catch((error) => Promise.reject(error));
  }
}

export const coreApiClient = new ApiClient(config.core);
export const recruitableApiClient = new ApiClient(config.recruitable);
