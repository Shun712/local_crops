import consumer from "./consumer"

// $(function() { ... }); で囲むことでレンダリング後に実行される
$(function() {
  if($("#chatroom").length > 0) {
    const chatroomId = $("#chatroom").data("chatroomId")
    const currentUserId = $("#chatroom").data("currentUserId")
    consumer.subscriptions.create({ channel: "ChatroomChannel", chatroom_id: chatroomId }, {
      connected: function() {
        console.log("connected")
      },
      disconnected: function() {
        console.log("disconnected")
      },
      received: function(data) {
        switch(data.type) {
          case "create":
            $('#chat-box').append(data.html);
            if($(`#chat-${data.chat.id}`).data("senderId") != currentUserId) {
              // 自分の投稿じゃない場合は編集・削除ボタンを非表示にする
              $(`#chat-${data.chat.id}`).find('.crud-area').hide()
            }
            if($(`#chat-${data.chat.id}`).data("senderId") == currentUserId) {
              // 自分の投稿の場合は入力フィールドをクリアする
              $('.input-chat-body').val('');
            }
            break;
          case "update":
            $(`#chat-${data.chat.id}`).replaceWith(data.html);
            if($(`#chat-${data.chat.id}`).data("senderId") != currentUserId) {
              // 自分の投稿じゃない場合は編集・削除ボタンを非表示にする
              $(`#chat-${data.chat.id}`).find('.crud-area').hide()
            }
            $("#chat-edit-modal").modal('hide');
            break;
          case "delete":
            $(`#chat-${data.chat.id}`).remove();
            break;
        }
      },
    });
  }
})
