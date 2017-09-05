module ApplicationHelper
  def phone_to(number)
    if number.present?
      link_to number_to_phone(number), "tel:#{number}"
    end
  end

  def sortable(column, title=nil)
    title = column.titleize
    join_column = column.pluralize + '.name'
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    # join columns dont change sort directions because,
    direction = (column == sort_column or join_column == sort_column) && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.permit!.merge({:sort => column, :direction => direction}), {:class => css_class}
  end

  def title
    if content_for?(:title)
      # allows the title to be set in the view by using t(".title")
      content_for :title
    else
      # look up translation key based on controller path, action name and .title
      # this works identical to the built-in lazy lookup
      t("#{ controller_path.tr('/', '.') }.#{ action_name }.title", default: :site_name)
    end
  end
end
