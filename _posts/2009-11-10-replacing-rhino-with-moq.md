---
title: Replacing Rhino with Moq
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Were just starting down the path of serious and extensive testing with mocks and fakes. Our initial tests were all done using Rhino Mocks, mostly because it had a well established reputation and we had no reason not to give it a try. The syntax is beautiful and did everything we needed, until we tried to make a test similar to this one pass successfully. </p>  <pre class="c#" name="code">public interface IFoo
{
    string Bar();
}

[Fact] public void TestWithRhino()
{
    var mock = MockRepository.GenerateStub&lt;IFoo&gt;();
    mock.Stub(x =&gt; x.Bar()).Return(&quot;bar&quot;);
    mock.Stub(x =&gt; x.Bar()).Return(&quot;baz&quot;);
    Assert.Equal(&quot;baz&quot;,mock.Bar());
}</pre>

<p>We couldnt, at least we couldnt using strictly stubs. From what I could gather, we could if we used a more complicated for of mocking besides stubs. We only need stubs, or fakes, because we dont need to test all the interaction, just the ending state. </p>

<p>Since we dont have any serious stock in using Rhino, as an alternative I decided to take a look at using Moq. The syntax for Moq is not as nice. It is more wordy, but I do like how it doesnt rely on extensions methods for everything. But what about the sample test?</p>

<pre class="c#" name="code">[Fact] public void TestWithMoq()
{
    var mock = new Mock&lt;IFoo&gt;();
    mock.Setup(x =&gt; x.Bar()).Returns(&quot;bar&quot;);
    mock.Setup(x =&gt; x.Bar()).Returns(&quot;baz&quot;);
    Assert.Equal(&quot;baz&quot;, mock.Object.Bar());
}</pre>

<p>It passes! Switching wasnt that difficult, but where is the ugly syntax Ive run into so far? Well this in Rhino:</p>

<pre class="c#" name="code">MockOrdersRepository.AssertWasNotCalled(x=&gt;x.StartOrder(null,null,null,null));</pre>

<p>...becomes this in Moq:</p>

<pre class="c#" name="code">MockOrdersRepository<br />   .Verify(x=&gt;x.StartOrder( It.IsAny&lt;string&gt;(),<br />                            It.IsAny&lt;string&gt;(),<br />                            It.IsAny&lt;string&gt;(),<br />                            It.IsAny&lt;string&gt;()),<br />              Times.Never());</pre>

<p>It might be I am not familiar enough with either to say that is the equivalent assertion of both, but it is working for us. I am probably missing something that is causing Moq to look more verbose.</p>
