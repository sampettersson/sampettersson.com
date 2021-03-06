App = require "../app"

App.controller 'applicationController', ($scope, $rootScope, deviceDetector) ->
  $scope.twitterLink = "https://www.twitter.com/fotomagin"

  $rootScope.device = {}
  $rootScope.device.mobile = deviceDetector.isMobile()
  $rootScope.device.desktop = deviceDetector.isDesktop()
  $rootScope.device.ios = deviceDetector.raw.os.ios
  $rootScope.device.android = deviceDetector.raw.os.android

App.directive 'applicationRoot', () ->
  directive = {}

  directive.restrict = "E"
  directive.templateUrl = "/client/views/applicationView.html"

  return directive

App.directive 'contactPopup', ($timeout, $http, $window) ->
  directive = {}

  directive.restrict = "E"
  directive.templateUrl = "/client/views/contactPopup.html"
  directive.link = ($scope, $element) ->

    $scope.contactPopup = {}

    $scope.contactPopup.to = "sam".concat("@").concat("sampettersson.com")

    $scope.contactPopup.send = () ->
      $http.post('/email', { email: $scope.contactPopup.email, message: $scope.contactPopup.message }).success (data) ->
        if !data.err
          $scope.contactPopup.success = true

    $scope.contact = () ->

      if !$scope.showContactPopup
        $scope.showContactPopup = true

        $scope.contactPopup.marginTop = 123

        $timeout () ->

          marginTop = -Math.abs($element[0].children[1].offsetHeight + 15)
          marginLeft = -Math.abs(($element[0].children[1].offsetWidth - $element[0].children[2].offsetWidth) / 2)

          $scope.contactPopup.marginTop = marginTop + "px"
          $scope.contactPopup.marginLeft = marginLeft + "px"
          $scope.animateContactPopup = true

        , 50

      else

        $scope.contactPopup.animateOut = true

        $timeout () ->
          $scope.contactPopup.animateOut = false
          $scope.showContactPopup = false
          $scope.animateContactPopup = false
        , 250

  return directive

