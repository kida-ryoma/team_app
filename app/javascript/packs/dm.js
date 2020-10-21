$(document).on('turbolinks:load', function(){
  function buildHTML(dm){
    // var content = message.content ? `${ message.content }` : "";
    var html = 
    `<div class = "self">
      <p class = "self__content">
        ${dm.content}
      </p>
    </div>`
    return html;
  }
  $('.chat-form').on('submit', function(e){ 
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.dm-content').append(html);
      $('.submit').prop('disabled', false);
      $('.content').val('');
      $('.dm-content').animate({ scrollTop: $('.dm-content')[0].scrollHeight},50);
    })
    .fail(function(data){
      alert ('メッセージ送信に失敗しました');
    })
  })
});