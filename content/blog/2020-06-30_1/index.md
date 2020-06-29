---
title: 블로그 정착기2
date: "2020-06-30T00:42:28.000Z"
description: 불편한 것들을 고쳐나가보자. 차근차근.
publish: true
---

> Be lazy.

토비의 스프링을 모두 읽었다!  
면접에서 결과가 나오기까지, 그리고 만약 합류하게된다면 인턴을 시작하기까지 시간동안 읽을만한 책을 추천받았다.  
`토비의 스프링`은 사실 스프링 레퍼런스를 열심히 읽으면서 공부를 하던 중에 한 번 접해본 책이었다. 아마 1월 정도였던 것으로 기억한다. 막 책으로 공부하는 것에 재미를 느낄 때 즈음이었다. "Java Programming Language", "실용주의 프로그래머", "프로그래밍 심리학", "클린 코드", "Algorithms" ... 정말 이때는 코딩 그런거 다 내려놓고 무작정 책만 읽었다. 책을 읽으면 읽을 수록 내 부족함이 느껴졌고, 책을 끝까지 한 권, 두 권, 읽으면서 얻는 성취감이 장난 아니었다.  
그때 토비의 스프링은 내가 포기한 책 중 하나였는데, (이거 말고는 "DDD" 관련이라던지... "Introduction to algorithms" 중반부라던지...) 당시에는 뭐가 주제인지 모르겠는 책이었다. 객체 지향 프로그래밍에 대해 뭐 겉핥기식으로 알고 있었던 것 같다. (그 당시에는 나름 자신있는 종목이었다.)  
뭐 이 이야기는 나중에 더 자세히 써봐야겠다.  

어쨌든 토비의 스프링! 전부 다 읽고 뻘짓하기 전에 블로그나 해볼까 싶어서 한참 삽질을 했다.  

## 비밀글
완벽한 비밀글 기능은 아니다. Git repo에 가면 결국 다 찾아볼 수는 있다. (그래서 아직 비밀글은 커밋을 안하기로 했다. 음..,, .gitignore에서 패턴을 추가해볼까 싶다.)  
`gatsby develop` 으로 사이트를 구동했을 때, 비밀글은 보이지 않게 했다. 
공부를 하다보니 알게된 사실인데, 각 마크다운 파일 상단에 있는 메타 데이터 정보를 `frontmatter`라고 한다.  
```
---
title: 블로그 정착기2
date: "2020-06-30T00:42:28.000Z"
description: 불편한 것들을 고쳐나가보자. 차근차근.
publish: true
---
```
현재글의 `frontmatter` 정보다. `publish` 라는 불린값을 추가했는데, `http://localhost:8000/___graphql`에서 이런저런 시도끝에 필터링을 추가해서 쉽게 기능을 구현했다. 
```
allMarkdownRemark(sort: { fields: [frontmatter___date], order: DESC }, filter: {frontmatter: {publish: {eq: true}}}) {
    ...
}
```
그런데 방금 다시 확인해보는데 메인 페이지(indexing)에서는 안보이는데, 하나의 글에 들어가면 거기서 `pre` 혹은 `next` 페이지로 노출이 되었다. 이건 `gatsby-node.js`에서 각 페이지에 대한 데이터 쿼리문에도 위와 동일한 필터링을 적용해서 해결했다.
```
allMarkdownRemark(
          sort: { fields: [frontmatter___date], order: DESC }
          limit: 1000
          filter: {frontmatter: {publish: {eq: true}}}
        )
        ...
```


## Auto Creating
자동 생성 기능을 추가했다. 이거때매 스크립트 공부를 또 오랜만에 해냈다. 필요에 의해 강제적으로 성장되는 기분이다.  
이제 프로젝트 루트 경로에서 `zsh create-post.sh` 명령어를 실행하면 해당 날짜 포맷으로 `2020-06-30_{N}` 폴더가 생성되고 그 안에 `index.md` 파일을 생성한다. `{N}`에는 기존에 있는 해당 날짜 폴더를 카운팅해서 매칭한다.  
파일 내부에는 `frontmatter`가 해당 날짜, 시간을 기준으로 작성된다.  
역시 예외 케이스를 해결하느라 `[]` 문법을 공부하고 와일드카드를 공부하고,, `for` 문... 이런저런 삽질을 많이했다.  
또 내가 이용하는 `zsh`는 `test` 문법에서 null이 나오면 그냥 throw 해버려서 이걸 또 한참 끙끙거리다가 해결했다. (`setopt NULL_GLOB`)  
덕분에 이제 구질구질하게 `date: 2020-06-30T00:42:28.000Z`를 입력하지 않아도 되게되었다. 😎  



확실히 코드를 이해할 수 있다는 점과 그걸 바탕으로 이렇게 저렇게 바꿔볼 수 있다는게 좋은 것 같다.  
엄청 대단한 기능을 추가한건 아니지만, 차차 내가 원하는 공간이 만들어지지 않을까 기대가 된다. 