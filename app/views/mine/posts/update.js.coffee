$('.app__main').empty()
$('.js-posts-list').html("<%= j render 'posts/list', posts: current_user.posts.order(created_at: :desc) %>")
$('#post-<%= @post.id %> .js-posts-list-item').click()
