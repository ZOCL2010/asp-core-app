#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM microsoft/dotnet:2.2-aspnetcore-runtime-nanoserver-sac2016 AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["asp-core-app/asp-core-app.csproj", "asp-core-app/"]
RUN dotnet restore "asp-core-app/asp-core-app.csproj"
COPY . .
WORKDIR "/src/asp-core-app"
RUN dotnet build "asp-core-app.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "asp-core-app.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "asp-core-app.dll"]