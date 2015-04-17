$('.js-post').empty()
$('.js-posts-list').html("<%= j render 'posts/list', posts: current_user.posts.order(created_at: :desc) %>")
$('.js-posts-list-item:first').click()
