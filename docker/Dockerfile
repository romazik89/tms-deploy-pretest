# УЧЕБНЫЙ ПРИМЕР. Адаптируйте версию .NET под вашу сборку TMS.
# Если есть исходники — используйте multi-stage build (sdk + aspnet).
# Если только опубликованные файлы — достаточно runtime-стадии.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app

# Копируем опубликованные файлы TMS (распакованный архив)
COPY ./publish/ ./

# Порт, который слушает приложение (по умолчанию 5000 для ASP.NET Core)
ENV ASPNETCORE_URLS=http://+:5000
EXPOSE 5000

# Имя DLL — проверьте в своём архиве TMS (может быть TMS.WebUI.dll или иное)
ENTRYPOINT ["dotnet", "TMS.WebUI.dll"]
