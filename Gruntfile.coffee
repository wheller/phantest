module.exports = (grunt) ->
  grunt.initConfig
    phantomas:
      gruntSite:
        options:
          indexPath:'./phantomas/'
          assertations:
            assetsWithQueryString:3
            biggestLatency:1400
            commentsSize:55
            consoleMessages:0
            jsErrors:0
          limitIncludedRuns:100
          group:
              Summary: [
                'onDOMReadyTime'
                'onDOMReadyTimeEnd'
                'windowOnLoadTime'
                'windowOnLoadTimeEnd'
                'requestsWithTimeout'
                'domainsToFirstPaint'
                'jQueryVersionsLoaded'
                'headersBiggerThanContent'
                'globalVariablesFalsy'
                'eventsScrollBound'
              ]
              REQUESTS: [
                'requests'
                'gzipRequests'
                'postRequests'
                'httpsRequests'
                'notFound'
                'multipleRequests'
                'maxRequestsPerDomain'
                'domains'
                'medianRequestsPerDomain'
                'redirects'
                'redirectsTime'
                'smallestResponse'
                'biggestResponse'
                'smallestLatency'
                'biggestLatency'
                'medianResponse'
                'medianLatency'
                'assetsNotGzipped'
                'assetsWithQueryString'
                'smallImages'
              ]
              'TIMINGS': [
                'timeToFirstByte'
                'timeToLastByte'
                'timeToFirstCss'
                'timeToFirstJs'
                'timeToFirstImage'
                'fastestResponse'
                'slowestResponse'
                'onDOMReadyTime'
                'onDOMReadyTimeEnd'
                'windowOnLoadTime'
                'windowOnLoadTimeEnd'
                'httpTrafficCompleted'
                'timeBackend'
                'timeFrontend'
              ]
              'HTML': [
                'bodyHTMLSize'
                'iframesCount'
                'imagesWithoutDimensions'
                'commentsSize'
                'hiddenContentSize'
                'whiteSpacesSize'
                'DOMelementsCount'
                'DOMelementMaxDepth'
                'nodesWithInlineCSS'
              ]
              'JAVASCRIPT': [
                'eventsBound'
                'documentWriteCalls'
                'evalCalls'
                'jsErrors'
                'consoleMessages'
                'windowAlerts'
                'windowConfirms'
                'windowPrompts'
                'globalVariables'
                'localStorageEntries'
                'ajaxRequests'
              ]
              'DOM': [
                'DOMqueries'
                'DOMqueriesById'
                'DOMqueriesByClassName'
                'DOMqueriesByTagName'
                'DOMqueriesByQuerySelectorAll'
                'DOMinserts'
                'DOMqueriesDuplicated'
              ]
              'HEADERS': [
                'headersCount'
                'headersSentCount'
                'headersRecvCount'
                'headersSize'
                'headersSentSize'
                'headersRecvSize'
              ]
              'CACHING': [
                'cacheHits'
                'cacheMisses'
                'cachePasses'
                'cachingNotSpecified'
                'cachingTooShort'
                'cachingDisabled'
              ]
              'COOKIES': [
                'cookiesSent'
                'cookiesRecv'
                'domainsWithCookies'
                'documentCookiesLength'
                'documentCookiesCount'
              ]
              'COUNTS & SIZES': [
                'contentLength'
                'bodySize'
                'htmlSize'
                'htmlCount'
                'cssSize'
                'cssCount'
                'jsSize'
                'jsCount'
                'jsonSize'
                'jsonCount'
                'imageSize'
                'imageCount'
                'webfontSize'
                'webfontCount'
                'base64Size'
                'base64Count'
                'otherCount'
                'otherSize'
              ]
              'JQUERY': [
                'jQueryOnDOMReadyFunctions'
                'jQuerySizzleCalls'
                'jQueryDOMReads'
                'jQueryDOMWrites'
                'jQueryDOMWriteReadSwitches'
              ]
          url:'http://www.cisco.com'
          buildUi:true
    pkg: grunt.file.readJSON 'package.json'
    coffee:
      compile:
        files:
          'lib/imgcache.js': ['src/*.coffee']
    nodeunit:
      files: ['test/*.coffee'],
      options:
        reporter: 'default'
    jshint:
      files: ['lib/**/*.js']
    exec:
      debug:
        command: 'node-debug --debug-brk $(which grunt) nodeunit'
      clean:
        command: 'rm -rf test/testcache'

  grunt.loadNpmTasks 'grunt-phantomas'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
#  grunt.loadNpmTasks 'grunt-contrib-nodeunit'
#  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-exec'
  grunt.registerTask 'clean', ['exec:clean']
  grunt.registerTask 'default', ['clean','coffee','nodeunit','jshint']
  grunt.registerTask 'build', ['coffee']
  grunt.registerTask 'test', ['clean','nodeunit','jshint']
  grunt.registerTask 'debug', ['clean','coffee','exec:debug']
