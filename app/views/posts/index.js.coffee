$('.app__main').empty()
$('.js-posts-list').html("<%= j render 'posts/list', posts: @posts %>")
$('.js-posts-list-item:first').click()
