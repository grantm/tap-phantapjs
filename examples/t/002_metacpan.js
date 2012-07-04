
var t = new Test('https://metacpan.org', {
    width:   1024,
    height:  768,
    verbose: true
});

t.open('/');

t.like(t.text('title'), /Search the CPAN/, 'home page title');

t.screenshot('./screenshot1.png');

t.done();
