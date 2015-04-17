$ ->
  $('#post-form')
    .on 'ajax:success', (xhr, data, status) =>
      $('#post-form textarea').prop('value', '')
      $('#post-modal').modal('hide')
    .on 'ajax:error', (xhr, status, error) =>
      alert error
