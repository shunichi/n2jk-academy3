module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML.new(hard_wrap: true),
        no_intra_emphasis: true,
        autolink: true,
        strikethrough: true,
        lax_spacing: true,
        tables: true,
        fenced_code_blocks: true,
        space_after_headers: true)
    renderer.render(sanitize(text)).html_safe
  end
end
