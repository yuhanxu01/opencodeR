from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('api/chat/', views.chat_api, name='chat_api'),
    path('api/config/', views.config_api, name='config_api'),
    path('api/session/<str:session_id>/', views.delete_session_proxy, name='delete_session_proxy'),
]
