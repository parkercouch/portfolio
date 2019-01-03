const ghpages = require('gh-pages');
ghpages.publish('build', {
  branch: 'master',
  repo: 'git@github.com:parkercouch/parkercouch.github.io.git',
  }, function(err) {
      if(err) {
        console.log(err);
      }
});
