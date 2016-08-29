module.exports = [
  'lodash'
  'localStorageService'
  (
    _
    localStorageService
  ) ->

    # page = localStorageService.get 'page'
    page =
      pet:
        name: 'Lacy'
        gender: 'Male'
        breed: 'Golden Retriever'
        date_of_birth: new Date()
        date_of_rest: new Date()
      banner: 'assets/images/dog-main.jpeg'
      memory: 'Pellentesque habitant molibero sit amet quam egestas semper sit semper sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris placerat eleifend leo. Quisque sit amet est et sapien ullamcorper pharetra.'
      biography: 'Pellentesque habitant molibero sit amet quam egestas semper. Aenean ultricies mi vitae est. Aenean ultricies mi vitae est.'
      imageA: 'assets/images/dog-main.jpeg'
      imageB: 'assets/images/dog-main.jpeg'
      imageC: 'assets/images/dog-main.jpeg'
      carousel: [
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ,
        image: 'assets/images/dog-main.jpeg'
      ]
      options:
        facebook:
          share: false
          comments: false
        twitter:
          share: false

]
