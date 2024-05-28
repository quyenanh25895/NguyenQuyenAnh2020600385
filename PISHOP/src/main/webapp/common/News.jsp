<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bản tin</title>
    <!-- Bootstrap CSS -->

</head>

<body>
<div class="container">
    <div id="articles" class="row"></div>
</div>

<!-- Bootstrap JS and jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    // Function to render articles
    function renderArticles(articles) {
        const articlesContainer = document.getElementById('articles');
        articles.slice(0, 9).forEach(article => { // Chỉ lấy 9 dữ liệu đầu tiên
            const articleElement = document.createElement('div');
            articleElement.classList.add('col-md-4', 'mb-4', 'article'); // Thêm lớp 'article'

            const cardElement = document.createElement('div');
            cardElement.classList.add('card', 'h-100');
            articleElement.appendChild(cardElement);

            // Tạo phần ảnh
            const imageElement = document.createElement('img');
            imageElement.classList.add('card-img-top');
            imageElement.alt = article.title;
            // Nếu có ảnh, sử dụng ảnh đó, nếu không, sử dụng ảnh xám
            imageElement.src = article.image_url ? article.image_url : 'https://via.placeholder.com/150x150?text=No+Image';
            cardElement.appendChild(imageElement);

            const cardBodyElement = document.createElement('div');
            cardBodyElement.classList.add('card-body');
            cardElement.appendChild(cardBodyElement);

            const titleElement = document.createElement('h5');
            titleElement.classList.add('card-title');
            const linkElement = document.createElement('a');
            linkElement.href = article.link;
            linkElement.textContent = article.title;
            titleElement.appendChild(linkElement);
            cardBodyElement.appendChild(titleElement);

            const descriptionElement = document.createElement('p');
            descriptionElement.classList.add('card-text');
            descriptionElement.textContent = article.description;
            cardBodyElement.appendChild(descriptionElement);

            const pubDateElement = document.createElement('p');
            pubDateElement.classList.add('card-text', 'text-muted');
            pubDateElement.textContent = article.pubDate;
            cardBodyElement.appendChild(pubDateElement);

            articlesContainer.appendChild(articleElement);
        });
    }
    var postAPI = "https://newsdata.io/api/1/news?country=vi&category=technology&apikey=pub_44228c1dd89c59f4823c5acb935387a112a31";
    // Fetch data from the API
    fetch(postAPI)
        .then(response => response.json())
        .then(data => {
            if (data.status === 'success') {
                renderArticles(data.results);
            } else {
                console.error('Failed to fetch articles');
            }
        })
        .catch(error => {
            console.error('Error fetching articles:', error);
        });

</script>
</body>

</html>
