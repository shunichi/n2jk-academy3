<% unless @post.user.has_unreads_for(current_user) %>
$('[data-user-id=<%= @post.user.id %>] .js-unread-dot').remove()
<% end %>
$('#post-<%= @post.id %> .js-unread-dot').remove()
