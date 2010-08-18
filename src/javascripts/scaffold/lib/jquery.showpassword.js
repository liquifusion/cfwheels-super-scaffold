(function($){
     $.fn.extend({
         showPassword: function(checkbox) {	
            return this.each(function() {
				
				var createClone = function(el){
					var el = $(el);
					var clone = $("<input type='text' />");
					clone.insertAfter(el).attr({
						'class':el.attr('class'),
						'style':el.attr('style')
					});
					return clone;
				};
				
				var update = function($this,$that){
					$that.val($this.val());
				};
				
				var set = function(){
					if($checkbox.is(':checked')){
						update($this,$clone);
						$clone.show();
						$this.hide();
					} else {
						update($clone,$this);
						$clone.hide();
						$this.show();
					}
				};
				
				var $clone = createClone(this),
					$this = $(this),
					$checkbox = $(checkbox);

				$checkbox.click(function(){set();});
				$this.keyup(function(){ update($this,$clone); });
				$clone.keyup(function(){ update($clone,$this); });
				
				set();

            });
        }
    });
})(jQuery);