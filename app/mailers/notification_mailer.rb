class NotificationMailer < ApplicationMailer
  helper ApplicationHelper

  def new_post(post)
    @post = post
    bcc = post.notification_emails
    mail(bcc: bcc, from: format_from(post.user.name), subject: format_subject(post.title)) unless bcc.blank?
  end

  def new_comment(comment)
    @comment = comment
    bcc = comment.notification_emails
    mail(bcc: bcc, from: format_from(comment.user.name), subject: format_subject(comment.post.title)) unless bcc.blank?
  end

  private
  def format_from(name)
    %!"#{name} (via n2jk-academy)" <n2jk-academy@sonicgarden.jp>!
  end
  def format_subject(subject)
    "[n2jk-academy] #{subject}"
  end
end
