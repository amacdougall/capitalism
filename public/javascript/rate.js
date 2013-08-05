$(document).ready(function() {
  RepWard.initStars();
});

// Create rating-specific functions within a function so they can use "private"
// locals; this is a simplistic implementation of the Module pattern.
(function() {
  RepWard.initStars = function() {
    var $starList = $("#stars");
    var $stars = $starList.find(".star");

    $starList.on("click", ".star", function() {
      var currentRating = getRatingFromStar(this);
      updateSubmitLink(currentRating);
      $stars.each(highlightBasedOnRating(currentRating));
    });
  };

  var getRatingFromStar = function(star) {
    var $star = $(star); // defensive re-wrap
    return parseInt($star.data("rating"), 10);
  };

  /**
   * Returns a function expecting a star DOM element, whose .highlight class
   * will be toggled by comparing the star's rating to the input rating.
   */
  var highlightBasedOnRating = function(rating) {
    // for $.each
    return function(index, star) {
      var $star = $(star);
      if (getRatingFromStar($star) <= rating) {
        $star.addClass("highlight");
      } else {
        $star.removeClass("highlight");
      }
    };
  };

  var updateSubmitLink = function(rating) {
    var $submit = $("#submit");
    if (rating >= 4) {
      $submit.find("a").attr("href", $submit.data("publish_link"));
    } else {
      $submit.find("a").attr("href", $submit.data("feedback_link"));
    }
  };
})();

