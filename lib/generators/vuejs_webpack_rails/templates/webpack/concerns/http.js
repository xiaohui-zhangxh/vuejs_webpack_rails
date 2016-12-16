var Vue = require('vue')
Vue.use(require('vue-resource'))

// Vue.http.options.root = '/api';
Vue.http.interceptors.push({
  request: function (request) {
    Vue.http.headers.common['X-CSRF-Token'] = $('[name="csrf-token"]').attr('content');
    return request;
  },
  response: function (response) {
    return response;
  }
});
