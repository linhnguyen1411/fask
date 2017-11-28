$(document).ready(function(){
  seen_all();
  var hash = window.location.hash;
  if (hash != "" && hash != 'undefiend'){
    $('html, body').animate({ scrollTop: $(hash).offset().top -80 },1500);
    $(hash).css('border', '2px solid red');
    setTimeout(function(){
      $(hash).css('border', '');
      }, 3000);
  }
  var loged = $('#user-loged-in').val();
  if(loged != false) {
    (function() {
      App.notifications = App.cable.subscriptions.create({
        channel: 'NotificationsChannel'
      },
      {
        connected: function() {},
        disconnected: function() {},
        received: function(data) {
          $.notify(data.mess);
          add_noti(data);
          noti(data);
        },
        update_counter: function(counter) {

        }
      });
    }).call(this);
  }
});
function noti(data) {
  var notification;
  notification = void 0;
  if (Notification.permission === 'granted') {
    notification = new Notification('', {
      icon: data.img,
      body: data.mess.replace(/\n/g, ' ').replace(/ +(?= )/g, '')
    });
    notification.onclick = function() {
      window.open(data.url);
    };
    return setTimeout((function() {
      notification.close();
    }), 15000);
  } else {
    return Notification.requestPermission();
  }
}

function add_noti(data) {
  var noti = $(".notification").find(".list-notifications");
  var list_noti = noti.find("li")
  var html = '<li><a href="' + data.url + '" class="notification-item status-no-seen" data-original-title="" '
    +'title=""><div class="col-md-2 text-center"><img class="user-avatar" src="'
    + data.img + '" alt="No avatar"></div><div class="col-md-10"><div class="row pd-top-10"><span class="user-name">'
    + data.name + '</span><span class="time">' + data.time + '</span></div><span class="row content">'
    + data.mess +'</span></div></a></li>';
  if(list_noti.length < 5) {
    noti.html(html + noti.html());
  }
  else {
    list_noti.splice(4, 1);
    var new_html = '';
    for(var i = 0; i < 4; i++) {
      new_html += list_noti[i].outerHTML;
    }
    noti.html(html + new_html);
  }
  $('.notification-count').find('.number').html(parseInt($('.notification-count').find('.number').html()) + 1);
}

function seen_all() {
  $('.notification-function-seen-all').click(function(){
    $.ajax({
      url: '/notifications/0',
      type: 'PUT',
      dataType: 'json',
      data: {},
      success: function (data) {
        if(data.type) {
          $('.status-no-seen').removeClass('status-no-seen');
          $('.number').text("0");
        }
        else if(data.not_login)
          window.location.replace('/users/sign_in');
        else
          sweetAlert(I18n.t('reactions.create.error'), '', 'error');
      },
      error: function () {
        response([]);
      }
    });
  });
}
