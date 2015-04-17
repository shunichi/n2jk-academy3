$('.js-post').html("<%= j render 'posts/post', post: @post %>")
$.ajax
  url: '<%= read_user_post_path(@post.user, @post) %>'
  type: 'PATCH'
  dataType: 'script'