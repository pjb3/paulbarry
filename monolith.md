As I was reading about the [Hanami Ruby web framework][hanami] and [making notes about how similar it is to an open-source web framework that I had been working on years ago][on-hanami], one of the [architectural principles of Hanami][hanami-arch] that caught my attention is a pattern proposed by Martin Fowler called [Monolith First][monolith-first]. I encourage you to read Fowler's article as well as the counterpoint posted on Fowler's site as well called [Don't Start Monolith][dont-start-monolith].

I find that the topic of monolith vs. microservices comes up often when working with software teams building applications. Many engineers today take it as fact that a monolithic architecture is just a flawed way to build software. The analogy I would make is to waterfall vs agile. It is widely accepted within modern product and engineering organizations that the waterfall methodology is a flawed, outdated model of working and that agile development is more productive. I have heard the term waterfall used to describe a broken product development process, meaning someone can make the statement "what we are doing is waterfall" and the person making the statement assumes that everyone they are speaking to knows the implication is that it is bad. In other words, waterfall is synonymous with broken or flawed. There is no one arguing that waterfall is better than agile.

I have also been in similar conversations where the term monolith is treated the same way. There is a general assumption that everyone agrees monolith is bad and microservices is good. This is not the case though, as there are people who do argue the benefits of monoliths, as Fowler, who is an extremely well-regarded software architect, is. Rails creator David Heinemeier Hansson makes the argument in favor of monolithic architecture and even tries to brand it in a positive light with the term that he coined ["The Majestic Monolith"][majestic-monolith].

The point that Fowler argues is that it isn't that a monolithic architecture is better, it is just that it has different advantages and disadvantages than a microservices architecture, and that the tradeoffs are in the favor of the monolith for new projects.

Now having been in many different technology organizations throughout my career and built many applications all across the spectrum of monolith to microservices and everything in between, I've come to agree with DHH on this issue, but here is the key point in his *Majestic Monolith* article:

**The biggest factor in determining whether you should just a monolithic or microservices architecture is the size of your team and organization.**

DHH isn't arguing that a monolith is better, he is saying that it is the right architecture for a small team. A microservices architecture isn't right for a small team in the same way that a monolith isn't right for a large organization.

So I think to Fowler's point on monolith first, I would say it depends on the size of the team and organization. If you are a building a new application at Amazon or Google, a monolith isn't going to make sense, but if if you are a 3 person startup, it does.

This is a prinicple that has been known within software development cirles for a long time, which was originally captured in [Conway's Law][conways-law], which states that architecture design of software systems tend to reflect the structure of the organizations that build them.

Therefore, I think you can think of the monolith vs microservices argument as a decision that ends up being made for you once you decide what the organization and the team building the application will look like. If you are going to have a small team, you are going to need a monolith and if you are going to have a big team, you are going to need a microservices architecture, so let that be your guide.

[hanami]: https://hanamirb.org/
[on-hanami]: http://www.paulbarry.com/articles/2020/03/22/hanami-a-better-rails
[hanami-arch]: https://guides.hanamirb.org/architecture/overview/
[monolith-first]: https://martinfowler.com/bliki/MonolithFirst.html
[dont-start-monolith]: https://martinfowler.com/articles/dont-start-monolith.html
[majestic-monolith]: https://m.signalvnoise.com/the-majestic-monolith/
[conways-law]: https://en.wikipedia.org/wiki/Conway%27s_law