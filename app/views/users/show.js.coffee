$('.js-user-header').html("<%= j render 'users/header', user: @user %>")
$('.js-post').empty()
$('.js-posts-list').html("<%= j render 'posts/list', posts: @user.posts.order(created_at: :desc) %>")
$('.js-posts-list-item:first').click()
