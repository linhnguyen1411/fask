$(document).ready(function() {
  var all_notification = $('#turn-all-notification');
  var all_email = $('#turn-all-email');
  var comments_post_fask = $('#turn-comments-post-fask');
  var comment_answer_fask = $('#turn-comment-answer-fask');
  var reply_post_fask = $('#turn-reply-post-fask');
  var like_comment_fask = $('#turn-like-comment-fask');
  var llc_answer_fask = $('#turn-llc-answer-fask');
  var clip_post_fask = $('#turn-clip-post-fask');
  var tag_post_fask = $('#turn-tag-posts-fask');
  var up_down_vote_post_fask = $('#turn-up-down-vote-post-fask');
  var follow_user_fask = $('#turn-follow-user-fask');
  var create_post_fask = $('#turn-create-post-fask');


  var comment_post_email = $('#turn-comments-post-email');
  var comment_answer_email = $('#turn-comment-answer-email');
  var reply_post_email = $('#turn-reply-post-email');
  var like_comment_email = $('#turn-like-comment-email');
  var llc_answer_email = $('#turn-llc-answer-email');
  var clip_post_email = $('#turn-clip-post-email');
  var tag_post_email = $('#turn-tag-posts-email');

    function setChecked(currentCheck, allCheck, otherCheck1, otherCheck2, otherCheck3,
    otherCheck4, otherCheck5, otherCheck6, otherCheck7, otherCheck8, otherCheck9) {
    if (currentCheck.is(':checked')) {
      if (otherCheck1.is(':checked') && otherCheck2.is(':checked') &&
        otherCheck3.is(':checked') && otherCheck4.is(':checked') &&
        otherCheck5.is(':checked') && otherCheck6.is(':checked') &&
        (otherCheck7 == '' ? true : otherCheck7.is(':checked')) &&
        (otherCheck8 == '' ? true : otherCheck8.is(':checked')) &&
        (otherCheck9 == '' ? true : otherCheck9.is(':checked'))) {
        allCheck.prop('checked', true);
      }
    }
    else {
      allCheck.prop('checked', false);
    }
  };
  all_notification.on('change', function() {
    if ($(this).is(':checked')) {
      comments_post_fask.prop('checked', true);
      comment_answer_fask.prop('checked', true);
      reply_post_fask.prop('checked', true);
      like_comment_fask.prop('checked', true);
      llc_answer_fask.prop('checked', true);
      clip_post_fask.prop('checked', true);
      tag_post_fask.prop('checked', true);
      up_down_vote_post_fask.prop('checked', true);
      follow_user_fask.prop('checked', true);
      create_post_fask.prop('checked', true);
    } else {
      comments_post_fask.prop('checked', false);
      comment_answer_fask.prop('checked', false);
      reply_post_fask.prop('checked', false);
      like_comment_fask.prop('checked', false);
      llc_answer_fask.prop('checked', false);
      clip_post_fask.prop('checked', false);
      tag_post_fask.prop('checked', false);
      up_down_vote_post_fask.prop('checked', false);
      follow_user_fask.prop('checked', false);
      create_post_fask.prop('checked', false);
    }
  });
  all_email.on('change', function() {
    if ($(this).is(':checked')) {
      comment_post_email.prop('checked', true);
      comment_answer_email.prop('checked', true);
      reply_post_email.prop('checked', true);
      like_comment_email.prop('checked', true);
      llc_answer_email.prop('checked', true);
      clip_post_email.prop('checked', true);
      tag_post_email.prop('checked', true);
    } else {
      comment_post_email.prop('checked', false);
      comment_answer_email.prop('checked', false);
      reply_post_email.prop('checked', false);
      like_comment_email.prop('checked', false);
      llc_answer_email.prop('checked', false);
      clip_post_email.prop('checked', false);
      tag_post_email.prop('checked', false);
    }
  });
  comments_post_fask.on('change', function() {
    setChecked(comments_post_fask, all_notification, comment_answer_fask,
      like_comment_fask, reply_post_fask, llc_answer_fask, clip_post_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  comment_answer_fask.on('change', function() {
    setChecked(comment_answer_fask, all_notification, comments_post_fask,
      reply_post_fask, like_comment_fask, llc_answer_fask, clip_post_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  reply_post_fask.on('change', function() {
    setChecked(reply_post_fask, all_notification, comment_answer_fask,
      comments_post_fask, like_comment_fask, llc_answer_fask, clip_post_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  like_comment_fask.on('change', function() {
    setChecked(like_comment_fask, all_notification, reply_post_fask,
      comment_answer_fask, comments_post_fask, llc_answer_fask, clip_post_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  llc_answer_fask.on('change', function() {
    setChecked(llc_answer_fask, all_notification, comment_answer_fask,
      comments_post_fask, reply_post_fask, like_comment_fask, clip_post_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  clip_post_fask.on('change', function() {
    setChecked(clip_post_fask, all_notification, reply_post_fask,
      comment_answer_fask, comments_post_fask, like_comment_fask, llc_answer_fask,
      tag_post_fask, up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  tag_post_fask.on('change', function() {
    setChecked(tag_post_fask, all_notification, like_comment_fask, reply_post_fask,
      comment_answer_fask, comments_post_fask, llc_answer_fask, clip_post_fask,
      up_down_vote_post_fask, follow_user_fask, create_post_fask);
  });
  up_down_vote_post_fask.on('change', function() {
    setChecked(up_down_vote_post_fask, all_notification, tag_post_fask,
      like_comment_fask, reply_post_fask, comment_answer_fask, comments_post_fask,
      llc_answer_fask, clip_post_fask, follow_user_fask, create_post_fask);
  });
  follow_user_fask.on('change', function() {
    setChecked(follow_user_fask, all_notification, up_down_vote_post_fask,
      tag_post_fask, like_comment_fask, reply_post_fask, comment_answer_fask,
      comments_post_fask, llc_answer_fask, clip_post_fask, create_post_fask);
  });
  create_post_fask.on('change', function() {
    setChecked(create_post_fask, all_notification, up_down_vote_post_fask,
      tag_post_fask, like_comment_fask, reply_post_fask, comment_answer_fask,
      comments_post_fask, llc_answer_fask, clip_post_fask, follow_user_fask);
  });
  comment_post_email.on('change', function() {
    setChecked(comment_post_email, all_email, comment_answer_email, reply_post_email,
      like_comment_email, llc_answer_email, clip_post_email, tag_post_email, '', '', '');
  });
  comment_answer_email.on('change', function() {
    setChecked(comment_answer_email, all_email, comment_post_email, reply_post_email,
      like_comment_email, llc_answer_email, clip_post_email, tag_post_email, '', '', '');
  });
  reply_post_email.on('change', function() {
    setChecked(reply_post_email, all_email, comment_answer_email, comment_post_email,
      like_comment_email, llc_answer_email, clip_post_email, tag_post_email, '', '', '');
  });
  like_comment_email.on('change', function() {
    setChecked(like_comment_email, all_email, llc_answer_email, clip_post_email,
      tag_post_email, reply_post_email, comment_answer_email, comment_post_email, '', '', '');
  });
  llc_answer_email.on('change', function() {
    setChecked(llc_answer_email, all_email, comment_answer_email, comment_post_email,
      reply_post_email, like_comment_email, clip_post_email, tag_post_email, '', '', '');
  });
  clip_post_email.on('change', function() {
    setChecked(clip_post_email, all_email, reply_post_email, comment_answer_email,
      comment_post_email, like_comment_email, llc_answer_email, tag_post_email, '', '', '');
  });
  tag_post_email.on('change', function() {
    setChecked(tag_post_email, all_email, like_comment_email, llc_answer_email,
      clip_post_email, reply_post_email, comment_answer_email, comment_post_email, '', '', '');
  });
});
