# Database Optimizations

## Normal Mode


  1. Total time in Chrome's timeline
  * Over 4000 seconds.

1. Add appropriate indices to the data structure (via migrations).
1. Record how long it takes to run the migrations that add indices.

  * 20.08 seconds
1. Reload the root page and record the four time numbers again.  Calculate your percent improvement in runtime.
  * Idle time = 35499.9ms
  * Time before HTML = 6.82 seconds
  * Memory = 510MB

1. Once you have optimized your code as much as you think you can, drop the database, run `rake db:migrate`, and then time how long it takes to run `rake db:seed`.  Was there an improvement or a worsening of runtime?  By what percent and why?
  * 'rake db:seeds' runtime increased by over 293%. The reason it took longer was because while indices decrease query times, they increase the time it takes for the database to populate with information.  The nature of indices require constant reordering while information is being entered into the database.

1. Which is faster: (a) running `rake db:seed` without indices and then running a migration to add indices, or (b) adding indices during your initial `rake db:migrate`, then running `rake db:seed`?
  * While seeding the database took longer after indices were added, I believe it's still faster in the long run to add the indices, migrate, then seed.
