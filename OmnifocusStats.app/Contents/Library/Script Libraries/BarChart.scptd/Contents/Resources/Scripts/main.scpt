JsOsaDAS1.001.00bplist00�Vscripto / * * 
   *   T e x t - B a s e d   B a r   C h a r t . 
   *   B a s e d   o n   B r e t t   T e r p s t r a ' s   R u b y   b a r   c h a r t :   h t t p s : / / g i s t . g i t h u b . c o m / t t s c o f f / 7 4 3 1 0 9 4 
   * / 
 
 
 
 
 / * * 
   *   C r e a t e   a   c h a r t   f r o m   t h e   r a w   d a t a .   
   *   
   *   @ p a r a m   r a w d a t a   A n   a r a y   o f   d a t a .   S h o u l d   a l r e a d y   b e   o r d e r e d   b y   d a t e . 
   * / 
 f u n c t i o n   c h a r t F r o m A r r a y (   r a w d a t a ,   m a x _ c o l u m n s ,   m a x _ r o w s   )   { 
 
 	 l e t   i n t e r e s t i n g d a t a   =   r a w d a t a . s l i c e (   (   - 1   *   m a x _ c o l u m n s )   ) ; 
 	 
 	 
 	 l e t   d a t e s   =   [ ] ,   t o t a l s   =   [ ] ; 
 	 i n t e r e s t i n g d a t a . f o r E a c h ( f u n c t i o n ( d a y )   { 
 	 	 d a t e s . p u s h (   d a y . d a t e   ) ; 
 	 	 t o t a l s . p u s h (   d a y . v a l u e   ) ; 
 	 } ) ; 
 	 
 	 l e t   d a y v a l u e s   =   t o t a l s . s l i c e ( ) ; 
 	 t o t a l s . s o r t ( ) ; 
 	 
 	 / /   g e t   m a x   &   m i n   v a l u e s 
 	 l e t   m a x   =   t o t a l s . s l i c e ( - 1 ) ; 
 	 l e t   m i n   =   t o t a l s [ 0 ] ; 
 	 
 	 / /   d e t e r m i n e   b a r   h e i g h t s 
 	 l e t   t o p l i n e   =   m a x _ r o w s   -   1 ; 
 	 l e t   s p r e a d   =   m a x   -   m i n ; 
 	 l e t   d i v   =   s p r e a d   /   t o p l i n e ;   / /   m a x   /   t o p l i n e 
 
 	 
 	 	 
 	 l e t   c h a r t   =   ' ' ; 
 	 
 	 / /   O u t p u t   e a c h   r o w .   I f   t h e   t o t a l   f o r   t h e   c o l u m n   i s   g r e a t e r 
 	 / /   t h a n   o r   e q u a l   t o   t h e   s c a l e d   r o w   c o u n t e r ,   o u t p u t   a   c h u n k   
 	 / /   o f   t h e   b a r 
 	 f o r ( l e t   l i n e = t o p l i n e ; l i n e > 0 ; l i n e - - )   { 
 	 	 d a y v a l u e s . f o r E a c h ( f u n c t i o n ( n u m )   { 
 	 	 	 i f (   ( ( n u m   -   m i n )   /   d i v )   >   l i n e   )   { 
 	 	 	 	 c h a r t   + =   "%�   " 
 	 	 	 }   e l s e   { 
 	 	 	 	 c h a r t   + =   "     " 
 	 	 	 } 
 	 	 
 	 	 } ) ; 
 	 	 c h a r t   + = " \ n " ; 
 	 } 
 	 
 	 t o t a l s . f o r E a c h ( f u n c t i o n ( n u m )   { 
 	 	 i f ( n u m   > =   m i n )   { 
 	 	 	 c h a r t   + =   "%�   " 
 	 	 }   e l s e   { 
 	 	 	 c h a r t   + =   "     " 
 	 	 } 
 	 	 
 	 	 
 	 } ) ; 
 	 c h a r t   + =   " \ n " ; 
 	 
 	 
 	 l e t   t o t a l   =   0 ; 
 	 t o t a l s . f o r E a c h ( f u n c t i o n ( n u m )   { 
 	 	 t o t a l   + =   n u m ; 
 	 } ) ; 
 	 l e t   a v g   =   t o t a l   /   t o t a l s . l e n g t h ; 
 	 
 	 c h a r t   + =   ` $ { n e w   D a t e ( d a t e s [ 0 ] ) . t o D a t e S t r i n g ( ) }   -   $ { n e w   D a t e ( d a t e s . s l i c e ( - 1 ) ) . t o D a t e S t r i n g ( ) }  !� T o d a y :   $ { d a y v a l u e s . s l i c e ( - 1 ) }   |   P e a k :   $ { m a x }   |   A v e r a g e :   $ { M a t h . r o u n d ( a v g ) } ` 
 	 
 	 	 
 	 r e t u r n   c h a r t ; 
 }                              jscr  ��ޭ