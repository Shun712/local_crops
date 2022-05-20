class ChatDecorator < ApplicationDecorator
  delegate_all
  def created_at
    helpers.content_tag :span, class: 'time' do
      object.created_at.strftime('%Y/%m/%d %H:%M')
    end
  end
end